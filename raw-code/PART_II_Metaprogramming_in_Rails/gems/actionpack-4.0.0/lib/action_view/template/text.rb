#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActionView #:nodoc:
  # = Action View Text Template
  class Template
    class Text #:nodoc:
      attr_accessor :type

      def initialize(string, type = nil)
        @string = string.to_s
        @type   = Types[type] || type if type
        @type ||= Types[:text]
      end

      def identifier
        'text template'
      end

      def inspect
        'text template'
      end

      def to_str
        @string
      end

      def render(*args)
        to_str
      end

      def formats
        [@type.to_sym]
      end
    end
  end
end
