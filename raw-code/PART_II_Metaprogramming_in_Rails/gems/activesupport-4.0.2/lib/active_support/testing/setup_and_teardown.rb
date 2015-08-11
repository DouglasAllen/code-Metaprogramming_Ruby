#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/concern'
require 'active_support/callbacks'

module ActiveSupport
  module Testing
    module SetupAndTeardown
      extend ActiveSupport::Concern

      included do
        include ActiveSupport::Callbacks
        define_callbacks :setup, :teardown
      end

      module ClassMethods
        def setup(*args, &block)
          set_callback(:setup, :before, *args, &block)
        end

        def teardown(*args, &block)
          set_callback(:teardown, :after, *args, &block)
        end
      end

      def before_setup
        super
        run_callbacks :setup
      end

      def after_teardown
        run_callbacks :teardown
        super
      end
    end
  end
end
