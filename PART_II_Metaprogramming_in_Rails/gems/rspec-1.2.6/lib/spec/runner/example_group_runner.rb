#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module Spec
  module Runner
    class ExampleGroupRunner
      def initialize(options)
        @options = options
      end

      def load_files(files)
        $KCODE = 'u' if RUBY_VERSION.to_f < 1.9
        # It's important that loading files (or choosing not to) stays the
        # responsibility of the ExampleGroupRunner. Some implementations (like)
        # the one using DRb may choose *not* to load files, but instead tell
        # someone else to do it over the wire.
        files.each do |file|
          load file
        end
      end

      def run
        prepare
        success = true
        example_groups.each do |example_group|
          success = success & example_group.run(@options)
        end
        return success
      ensure
        finish
      end

    protected

      def prepare
        reporter.start(number_of_examples)
        example_groups.reverse! if reverse
      end

      def finish
        reporter.end
        reporter.dump
      end

      def reporter
        @options.reporter
      end

      def reverse
        @options.reverse
      end

      def example_groups
        @options.example_groups
      end

      def number_of_examples
        @options.number_of_examples
      end
    end
  end
end
