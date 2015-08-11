#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module Spec
  module Matchers
    # :call-seq:
    #   should be_instance_of(expected)
    #   should be_an_instance_of(expected)
    #   should_not be_instance_of(expected)
    #   should_not be_an_instance_of(expected)
    #
    # Passes if actual.instance_of?(expected)
    #
    # == Examples
    #
    #   5.should be_instance_of(Fixnum)
    #   5.should_not be_instance_of(Numeric)
    #   5.should_not be_instance_of(Float)
    def be_an_instance_of(expected)
      Matcher.new :be_an_instance_of, expected do |_expected_|
        match do |actual|
          actual.instance_of?(_expected_)
        end
      end
    end
    
    alias_method :be_instance_of, :be_an_instance_of
  end
end
