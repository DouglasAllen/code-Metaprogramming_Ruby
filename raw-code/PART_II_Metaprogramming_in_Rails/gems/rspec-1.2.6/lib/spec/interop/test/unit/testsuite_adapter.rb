#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module Test
  module Unit
    class TestSuiteAdapter < TestSuite
      attr_reader :example_group, :examples
      alias_method :tests, :examples
      def initialize(example_group)
        @example_group = example_group
        @examples = example_group.examples
      end

      def name
        example_group.description
      end

      def run(*args)
        return true unless args.empty?
        example_group.run(Spec::Runner.options)
      end

      def size
        example_group.number_of_examples
      end

      def delete(example)
        examples.delete example
      end

      def empty?
        examples.empty?
      end
    end
  end
end

