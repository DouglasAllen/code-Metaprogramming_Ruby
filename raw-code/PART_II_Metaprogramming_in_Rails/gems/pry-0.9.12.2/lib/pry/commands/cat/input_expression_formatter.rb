#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  class Command::Cat
    class InputExpressionFormatter < AbstractFormatter
      attr_accessor :input_expressions
      attr_accessor :opts

      def initialize(input_expressions, opts)
        @input_expressions = input_expressions
        @opts = opts
      end

      def format
        raise CommandError, "No input expressions!" if numbered_input_items.length < 1

        if numbered_input_items.length > 1
          content = ""
          numbered_input_items.each do |i, s|
            content << "#{Helpers::Text.bold(i.to_s)}:\n" << decorate(Pry::Code(s).with_indentation(2)).to_s
          end

          content
        else
          decorate(Pry::Code(selected_input_items.first)).to_s
        end
      end

      private

      def selected_input_items
        input_expressions[normalized_expression_range] || []
      end

      def numbered_input_items
        @numbered_input_items ||= normalized_expression_range.zip(selected_input_items).
          reject { |_, s| s.nil? || s == "" }
      end

      def normalized_expression_range
        absolute_index_range(opts[:i], input_expressions.length)
      end
    end
  end
end
