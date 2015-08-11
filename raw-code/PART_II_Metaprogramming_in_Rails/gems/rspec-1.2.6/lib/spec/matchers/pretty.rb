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
    module Pretty
      def split_words(sym)
        sym.to_s.gsub(/_/,' ')
      end

      def to_sentence(words)
        words = words.map{|w| w.inspect}
        case words.length
          when 0
            ""
          when 1
            " #{words[0]}"
          when 2
            " #{words[0]} and #{words[1]}"
          else
            " #{words[0...-1].join(', ')}, and #{words[-1]}"
        end
      end

      def _pretty_print(array)
        result = ""
        array.each_with_index do |item, index|
          if index < (array.length - 2)
            result << "#{item.inspect}, "
          elsif index < (array.length - 1)
            result << "#{item.inspect} and "
          else
            result << "#{item.inspect}"
          end
        end
        result
      end
    end
  end
end