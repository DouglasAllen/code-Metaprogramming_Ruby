#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module Spec
  module Mocks
    
    class ArgumentExpectation
      attr_reader :args
      
      def initialize(args, &block)
        @args = args
        @matchers_block = block
        @match_any_args = false
        @matchers = nil
        
        if ArgumentMatchers::AnyArgsMatcher === args.first
          @match_any_args = true
        elsif ArgumentMatchers::NoArgsMatcher === args.first
          @matchers = []
        else
          @matchers = args.collect {|arg| matcher_for(arg)}
        end
      end
      
      def matcher_for(arg)
        return ArgumentMatchers::MatcherMatcher.new(arg)   if is_matcher?(arg)
        return ArgumentMatchers::RegexpMatcher.new(arg) if arg.is_a?(Regexp)
        return ArgumentMatchers::EqualityProxy.new(arg)
      end
      
      def is_matcher?(obj)
        return obj.respond_to?(:matches?) & obj.respond_to?(:description)
      end
      
      def args_match?(given_args)
        match_any_args? || matchers_block_matches?(given_args) || matchers_match?(given_args)
      end
      
      def matchers_block_matches?(given_args)
        @matchers_block ? @matchers_block.call(*given_args) : nil
      end
      
      def matchers_match?(given_args)
        @matchers == given_args
      end
      
      def match_any_args?
        @match_any_args
      end
      
    end
    
  end
end
