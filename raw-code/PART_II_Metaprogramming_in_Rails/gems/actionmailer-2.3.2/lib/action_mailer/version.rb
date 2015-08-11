#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module ActionMailer
  module VERSION #:nodoc:
    MAJOR = 2
    MINOR = 3
    TINY  = 2

    STRING = [MAJOR, MINOR, TINY].join('.')
  end
end
