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
    class ExamplePendingError < StandardError; end
    
    class NotYetImplementedError < ExamplePendingError
      MESSAGE = "Not Yet Implemented"
      def initialize
        super(MESSAGE)
      end
    end

    class PendingExampleFixedError < StandardError; end
    
    class NoDescriptionError < ArgumentError
      def initialize(kind, location)
        super("No description supplied for #{kind} declared on #{location}")
      end
    end
  end
end
