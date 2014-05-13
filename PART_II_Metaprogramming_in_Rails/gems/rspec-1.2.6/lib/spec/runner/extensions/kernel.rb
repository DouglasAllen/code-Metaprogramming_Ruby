#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module Kernel
  unless respond_to?(:debugger)
    # Start a debugging session if ruby-debug is loaded with the -u/--debugger option
    def debugger(steps=1)
      # If not then just comment and proceed
      $stderr.puts "debugger statement ignored, use -u or --debugger option on rspec to enable debugging"
    end
  end
end
