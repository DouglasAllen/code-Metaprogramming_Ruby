#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
irb = RUBY_PLATFORM =~ /(:?mswin|mingw)/ ? 'irb.bat' : 'irb'

require 'optparse'

options = { :sandbox => false, :irb => irb }
OptionParser.new do |opt|
  opt.banner = "Usage: console [environment] [options]"
  opt.on('-s', '--sandbox', 'Rollback database modifications on exit.') { |v| options[:sandbox] = v }
  opt.on("--irb=[#{irb}]", 'Invoke a different irb.') { |v| options[:irb] = v }
  opt.on("--debugger", 'Enable ruby-debugging for the console.') { |v| options[:debugger] = v }
  opt.parse!(ARGV)
end

libs =  " -r irb/completion"
libs << %( -r "#{RAILS_ROOT}/config/environment")
libs << " -r console_app"
libs << " -r console_sandbox" if options[:sandbox]
libs << " -r console_with_helpers"

if options[:debugger]
  begin
    require 'ruby-debug'
    libs << " -r ruby-debug"
    puts "=> Debugger enabled"
  rescue Exception
    puts "You need to install ruby-debug to run the console in debugging mode. With gems, use 'gem install ruby-debug'"
    exit
  end
end

ENV['RAILS_ENV'] = case ARGV.first
  when "p"; "production"
  when "d"; "development"
  when "t"; "test"
  else
    ARGV.first || ENV['RAILS_ENV'] || 'development'
end

if options[:sandbox]
  puts "Loading #{ENV['RAILS_ENV']} environment in sandbox (Rails #{Rails.version})"
  puts "Any modifications you make will be rolled back on exit"
else
  puts "Loading #{ENV['RAILS_ENV']} environment (Rails #{Rails.version})"
end
exec "#{options[:irb]} #{libs} --simple-prompt"
