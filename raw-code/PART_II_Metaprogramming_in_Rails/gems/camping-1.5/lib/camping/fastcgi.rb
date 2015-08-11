#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
# == About camping/fastcgi.rb
#
# Camping works very well with FastCGI, since your application is only loaded
# once -- when FastCGI starts.  In addition, this class lets you mount several
# Camping apps under a single FastCGI process, to help save memory costs.
#
# So where do you use the Camping::FastCGI class?  Use it in your application's
# postamble and then you can point your web server directly at your application.
# See Camping::FastCGI docs for more.
require 'camping'
require 'fcgi'

module Camping
# Camping::FastCGI is a small class for hooking one or more Camping apps up to
# FastCGI.  Generally, you'll use this class in your application's postamble.
#
# == The Smallest Example
#
#  if __FILE__ == $0
#    require 'camping/fastcgi'
#    Camping::FastCGI.start(YourApp)
#  end
#
# This example is stripped down to the basics.  The postamble has no database
# connection.  It just loads this class and calls Camping::FastCGI.start.
#
# Now, in Lighttpd or Apache, you can point to your app's file, which will
# be executed, only to discover that your app now speaks the FastCGI protocol.
#
# Here's a sample lighttpd.conf (tested with Lighttpd 1.4.11) to serve as example:
#
#   server.port                 = 3044
#   server.bind                 = "127.0.0.1"
#   server.modules              = ( "mod_fastcgi" )
#   server.document-root        = "/var/www/camping/blog/" 
#   server.errorlog             = "/var/www/camping/blog/error.log" 
#   
#   #### fastcgi module
#   fastcgi.server = ( "/" => ( 
#     "localhost" => ( 
#       "socket" => "/tmp/camping-blog.socket",
#       "bin-path" => "/var/www/camping/blog/blog.rb",
#       "check-local" => "disable",
#       "max-procs" => 1 ) ) )
#
# The file <tt>/var/www/camping/blog/blog.rb</tt> is the Camping app with
# the postamble.
#
# == Mounting Many Apps
#
#  require 'camping/fastcgi'
#  fast = Camping::FastCGI.new
#  fast.mount("/blog", Blog)
#  fast.mount("/tepee", Tepee)
#  fast.mount("/", Index)
#  fast.start
#
class FastCGI
    CHUNK_SIZE=(4 * 1024)

    # Creates a Camping::FastCGI class with empty mounts.
    def initialize
        @mounts = {}
    end
    # Mounts a Camping application.  The +dir+ being the name of the directory
    # to serve as the application's root.  The +app+ is a Camping class.
    def mount(dir, app)
        dir.gsub!(/\/{2,}/, '/')
        dir.gsub!(/\/+$/, '')
        @mounts[dir] = app
    end
    # 
    # Starts the FastCGI main loop.
    def start
        FCGI.each do |req|
            dir, app = nil
            begin
                root, path = "/"
                if ENV['FORCE_ROOT'] and ENV['FORCE_ROOT'].to_i == 1
                  path = req.env['REQUEST_URI']
                else
                  root = req.env['SCRIPT_NAME']
                  path = req.env['PATH_INFO']
                end

                dir, app = @mounts.max { |a,b| match(path, a[0]) <=> match(path, b[0]) }
                unless dir and app
                    dir, app = '/', Camping
                end
                yield dir, app if block_given?

                req.env['SERVER_SCRIPT_NAME'] = req.env['SCRIPT_NAME']
                req.env['SERVER_PATH_INFO'] = req.env['PATH_INFO']
                req.env['SCRIPT_NAME'] = File.join(root, dir)
                req.env['PATH_INFO'] = path.gsub(/^#{dir}/, '')

                controller = app.run(req.in, req.env)
                sendfile = nil
                headers = {}
                controller.headers.each do |k, v|
                  if k =~ /^X-SENDFILE$/i and !ENV['SERVER_X_SENDFILE']
                    sendfile = v
                  else
                    headers[k] = v
                  end
                end

                body = controller.body
                controller.body = ""
                controller.headers = headers

                req.out << controller.to_s
                if sendfile
                  File.open(sendfile, "rb") do |f|
                    while chunk = f.read(CHUNK_SIZE) and chunk.length > 0
                      req.out << chunk
                    end
                  end
                elsif body.respond_to? :read
                  while chunk = body.read(CHUNK_SIZE) and chunk.length > 0
                    req.out << chunk
                  end
                  body.close if body.respond_to? :close
                else
                  req.out << body.to_s
                end
            rescue Exception => e
                req.out << "Content-Type: text/html\r\n\r\n" +
                    "<h1>Camping Problem!</h1>" +
                    "<h2><strong>#{root}</strong>#{path}</h2>" + 
                    "<h3>#{e.class} #{esc e.message}</h3>" +
                    "<ul>" + e.backtrace.map { |bt| "<li>#{esc bt}</li>" }.join + "</ul>" +
                    "<hr /><p>#{req.env.inspect}</p>"
            ensure
                req.finish
            end
        end
    end

    # A simple single-app starter mechanism
    #
    #   Camping::FastCGI.start(Blog)
    #
    def self.start(app)
        cf = Camping::FastCGI.new
        cf.mount("/", app)
        cf.start
    end

    # Serve an entire directory of Camping apps. (See 
    # http://code.whytheluckystiff.net/camping/wiki/TheCampingServer.)
    #
    # Use this method inside your FastCGI dispatcher:
    #
    #   #!/usr/local/bin/ruby
    #   require 'rubygems'
    #   require 'camping/fastcgi'
    #   Camping::Models::Base.establish_connection :adapter => 'sqlite3', :database => "/path/to/db"
    #   Camping::FastCGI.serve("/home/why/cvs/camping/examples")
    # 
    def self.serve(path, index=nil)
        require 'camping/reloader'
        if File.directory? path
            fast = Camping::FastCGI.new
            script_load = proc do |script|
                app = Camping::Reloader.new(script)
                fast.mount("/#{app.mount}", app)
                app
            end
            Dir[File.join(path, '*.rb')].each &script_load
            fast.mount("/", index) if index

            fast.start do |dir, app|
                 Dir[File.join(path, dir, '*.rb')].each do |script|
                     smount = "/" + File.basename(script, '.rb')
                     script_load[script] unless @mounts.has_key? smount
                 end
            end
        else
            start(Camping::Reloader.new(path))
        end
    end

    private

    def match(path, mount)
        m = path.match(/^#{Regexp::quote mount}(\/|$)/)
        if m; m.end(0)
        else  -1
        end
    end

    def esc(str)
        str.gsub(/&/n, '&amp;').gsub(/\"/n, '&quot;').gsub(/>/n, '&gt;').gsub(/</n, '&lt;')
    end

end
end
