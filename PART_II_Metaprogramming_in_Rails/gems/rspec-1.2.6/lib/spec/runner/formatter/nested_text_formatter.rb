#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'spec/runner/formatter/base_text_formatter'

module Spec
  module Runner
    module Formatter
      class NestedTextFormatter < BaseTextFormatter
        def initialize(options, where)
          super
          @last_nested_descriptions = []
        end

        def example_group_started(example_group)
          super

          example_group.nested_descriptions.each_with_index do |nested_description, i|
            unless nested_description == @last_nested_descriptions[i]
              output.puts "#{'  ' * i}#{nested_description}"
            end
          end

          @last_nested_descriptions = example_group.nested_descriptions
        end

        def example_failed(example, counter, failure)
          output.puts(red("#{current_indentation}#{example.description} (FAILED - #{counter})"))
          output.flush
        end

        def example_passed(example)
          message = "#{current_indentation}#{example.description}"
          output.puts green(message)
          output.flush
        end

        def example_pending(example, message, deprecated_pending_location=nil)
          super
          output.puts yellow("#{current_indentation}#{example.description} (PENDING: #{message})")
          output.flush
        end

        def current_indentation
          '  ' * @last_nested_descriptions.length
        end
      end
    end
  end
end
