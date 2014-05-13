#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'strscan'

module ActionDispatch
  module Journey # :nodoc:
    class Scanner # :nodoc:
      def initialize
        @ss = nil
      end

      def scan_setup(str)
        @ss = StringScanner.new(str)
      end

      def eos?
        @ss.eos?
      end

      def pos
        @ss.pos
      end

      def pre_match
        @ss.pre_match
      end

      def next_token
        return if @ss.eos?

        until token = scan || @ss.eos?; end
        token
      end

      private

        def scan
          case
            # /
          when text = @ss.scan(/\//)
            [:SLASH, text]
          when text = @ss.scan(/\*\w+/)
            [:STAR, text]
          when text = @ss.scan(/\(/)
            [:LPAREN, text]
          when text = @ss.scan(/\)/)
            [:RPAREN, text]
          when text = @ss.scan(/\|/)
            [:OR, text]
          when text = @ss.scan(/\./)
            [:DOT, text]
          when text = @ss.scan(/:\w+/)
            [:SYMBOL, text]
          when text = @ss.scan(/[\w%\-~]+/)
            [:LITERAL, text]
            # any char
          when text = @ss.scan(/./)
            [:LITERAL, text]
          end
        end
    end
  end
end
