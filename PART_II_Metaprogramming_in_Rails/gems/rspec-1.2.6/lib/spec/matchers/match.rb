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
    #   should match(regexp)
    #   should_not match(regexp)
    #
    # Given a Regexp, passes if actual =~ regexp
    #
    # == Examples
    #
    #   email.should match(/^([^\s]+)((?:[-a-z0-9]+\.)+[a-z]{2,})$/i)
    def match(expected)
      Matcher.new :match, expected do |_expected_|
        match do |actual|
          actual =~ _expected_
        end
      end
    end
  end
end
