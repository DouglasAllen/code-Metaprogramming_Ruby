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
    #   should be_close(expected, delta)
    #   should_not be_close(expected, delta)
    #
    # Passes if actual == expected +/- delta
    #
    # == Example
    #
    #   result.should be_close(3.0, 0.5)
    def be_close(expected, delta)
      Matcher.new :be_close, expected, delta do |_expected_, _delta_|
        match do |actual|
          (actual - _expected_).abs < _delta_
        end

        failure_message_for_should do |actual|
          "expected #{_expected_} +/- (< #{_delta_}), got #{actual}"
        end

        failure_message_for_should_not do |actual|
          "expected #{_expected_} +/- (< #{_delta_}), got #{actual}"
        end

        description do
          "be close to #{_expected_} (within +- #{_delta_})"
        end
      end
    end
  end
end
