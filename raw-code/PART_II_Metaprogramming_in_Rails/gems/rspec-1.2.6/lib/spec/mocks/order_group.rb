#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module Spec
  module Mocks
    class OrderGroup
      def initialize error_generator
        @error_generator = error_generator
        @ordering = Array.new
      end
      
      def register(expectation)
        @ordering << expectation
      end
      
      def ready_for?(expectation)
        return @ordering.first == expectation
      end
      
      def consume
        @ordering.shift
      end
      
      def handle_order_constraint expectation
        return unless @ordering.include? expectation
        return consume if ready_for?(expectation)
        @error_generator.raise_out_of_order_error expectation.sym
      end
      
    end
  end
end
