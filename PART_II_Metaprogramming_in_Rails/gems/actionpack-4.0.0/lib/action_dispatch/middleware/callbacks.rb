#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---

module ActionDispatch
  # Provide callbacks to be executed before and after the request dispatch.
  class Callbacks
    include ActiveSupport::Callbacks

    define_callbacks :call

    class << self
      delegate :to_prepare, :to_cleanup, :to => "ActionDispatch::Reloader"
    end

    def self.before(*args, &block)
      set_callback(:call, :before, *args, &block)
    end

    def self.after(*args, &block)
      set_callback(:call, :after, *args, &block)
    end

    def initialize(app)
      @app = app
    end

    def call(env)
      error = nil
      result = run_callbacks :call do
        begin
          @app.call(env)
        rescue => error
        end
      end
      raise error if error
      result
    end
  end
end
