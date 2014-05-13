#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'action_dispatch/middleware/session/abstract_store'
begin
  require 'rack/session/dalli'
rescue LoadError => e
  $stderr.puts "You don't have dalli installed in your application. Please add it to your Gemfile and run bundle install"
  raise e
end

module ActionDispatch
  module Session
    class MemCacheStore < Rack::Session::Dalli
      include Compatibility
      include StaleSessionCheck
      include SessionObject

      def initialize(app, options = {})
        options[:expire_after] ||= options[:expires]
        super
      end
    end
  end
end
