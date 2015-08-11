#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Rails
  module Rack
    class Debugger
      def initialize(app)
        @app = app

        require_library_or_gem 'ruby-debug'
        ::Debugger.start
        ::Debugger.settings[:autoeval] = true if ::Debugger.respond_to?(:settings)
        puts "=> Debugger enabled"
      rescue Exception
        puts "You need to install ruby-debug to run the server in debugging mode. With gems, use 'gem install ruby-debug'"
        exit
      end

      def call(env)
        @app.call(env)
      end
    end
  end
end
