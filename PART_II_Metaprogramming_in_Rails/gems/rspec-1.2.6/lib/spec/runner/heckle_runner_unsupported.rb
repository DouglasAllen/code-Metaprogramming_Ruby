#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module Spec
  module Runner
    # Dummy implementation for Windows that just fails (Heckle is not supported on Windows)
    class HeckleRunner
      def initialize(filter)
        raise "Heckle is not supported on Windows or Ruby 1.9"
      end
    end
  end
end
