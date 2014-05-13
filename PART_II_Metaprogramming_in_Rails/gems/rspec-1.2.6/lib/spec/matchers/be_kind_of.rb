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
    #   should be_kind_of(expected)
    #   should be_a_kind_of(expected)
    #   should_not be_kind_of(expected)
    #   should_not be_a_kind_of(expected)
    #
    # Passes if actual.kind_of?(expected)
    #
    # == Examples
    #
    #   5.should be_kind_of(Fixnum)
    #   5.should be_kind_of(Numeric)
    #   5.should_not be_kind_of(Float)
    def be_a_kind_of(expected)
      Matcher.new :be_a_kind_of, expected do |_expected_|
        match do |actual|
          actual.kind_of?(_expected_)
        end
      end
    end
    
    alias_method :be_kind_of, :be_a_kind_of
  end
end
