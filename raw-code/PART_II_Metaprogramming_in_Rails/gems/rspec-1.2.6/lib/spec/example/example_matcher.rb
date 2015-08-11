#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module Spec
  module Example
    class ExampleMatcher
      def initialize(example_group_description, example_name)
        @example_group_description = example_group_description
        @example_name = example_name
      end
      
      def matches?(specified_examples)
        specified_examples.any? do |specified_example|
          matches_literal_example?(specified_example) || matches_example_not_considering_modules?(specified_example)
        end
      end
      
      protected
      def matches_literal_example?(specified_example)
        specified_example =~ /(^#{example_group_regex} #{example_regexp}$|^#{example_group_regex}$|^#{example_group_with_before_all_regexp}$|^#{example_regexp}$)/
      end

      def matches_example_not_considering_modules?(specified_example)
        specified_example =~ /(^#{example_group_regex_not_considering_modules} #{example_regexp}$|^#{example_group_regex_not_considering_modules}$|^#{example_regexp}$)/
      end

      def example_group_regex
        Regexp.escape(@example_group_description)
      end

      def example_group_with_before_all_regexp
        Regexp.escape("#{@example_group_description} before(:all)")
      end

      def example_group_regex_not_considering_modules
        Regexp.escape(@example_group_description.split('::').last)
      end

      def example_regexp
        Regexp.escape(@example_name)
      end
    end

    ExampleGroupMethods.matcher_class = ExampleMatcher
  end
end
