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
    class InvalidMatcherError < ArgumentError; end        
    
    class PositiveExpectationHandler        
      def self.handle_matcher(actual, matcher, &block)
        ::Spec::Matchers.last_should = :should
        ::Spec::Matchers.last_matcher = matcher
        return ::Spec::Matchers::PositiveOperatorMatcher.new(actual) if matcher.nil?

        match = matcher.matches?(actual, &block)
        return match if match
        
        message = matcher.respond_to?(:failure_message_for_should) ?
                  matcher.failure_message_for_should :
                  matcher.failure_message
        
        if matcher.respond_to?(:diffable?) && matcher.diffable?
          ::Spec::Expectations.fail_with message, matcher.expected.first, matcher.actual
        else
          ::Spec::Expectations.fail_with message
        end
      end
    end

    class NegativeExpectationHandler
      def self.handle_matcher(actual, matcher, &block)
        ::Spec::Matchers.last_should = :should_not
        ::Spec::Matchers.last_matcher = matcher
        return ::Spec::Matchers::NegativeOperatorMatcher.new(actual) if matcher.nil?
        
        match = matcher.respond_to?(:does_not_match?) ?
                !matcher.does_not_match?(actual, &block) :
                matcher.matches?(actual, &block)
        return match unless match
        
        message = matcher.respond_to?(:failure_message_for_should_not) ?
                  matcher.failure_message_for_should_not :
                  matcher.negative_failure_message

        if matcher.respond_to?(:diffable?) && matcher.diffable?
          ::Spec::Expectations.fail_with message, matcher.expected.first, matcher.actual
        else
          ::Spec::Expectations.fail_with message
        end
      end
    end
  end
end

