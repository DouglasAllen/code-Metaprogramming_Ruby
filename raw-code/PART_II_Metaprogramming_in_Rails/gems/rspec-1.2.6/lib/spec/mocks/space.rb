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
    class Space
      def add(obj)
        mocks << obj unless mocks.detect {|m| m.equal? obj}
      end

      def verify_all
        mocks.each do |mock|
          mock.rspec_verify
        end
      end
      
      def reset_all
        mocks.each do |mock|
          mock.rspec_reset
        end
        mocks.clear
      end
      
    private
    
      def mocks
        @mocks ||= []
      end
    end
  end
end
