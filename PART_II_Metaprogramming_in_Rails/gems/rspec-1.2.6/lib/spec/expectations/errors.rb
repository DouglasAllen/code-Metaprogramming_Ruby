#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module Spec
  module Expectations
    # If Test::Unit is loaed, we'll use its error as baseclass, so that Test::Unit
    # will report unmet RSpec expectations as failures rather than errors.
    superclass = ['Test::Unit::AssertionFailedError', '::StandardError'].map do |c|
      eval(c) rescue nil
    end.compact.first
    
    class ExpectationNotMetError < superclass
    end
  end
end
