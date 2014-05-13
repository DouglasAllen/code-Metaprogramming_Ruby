#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module Spec
  module Example      
    module Pending
      def pending(message = "TODO")
        if block_given?
          begin
            yield
          rescue Exception
            raise Spec::Example::ExamplePendingError.new(message)
          end
          raise Spec::Example::PendingExampleFixedError.new("Expected pending '#{message}' to fail. No Error was raised.")
        else
          raise Spec::Example::ExamplePendingError.new(message)
        end
      end
    end
  end
end
