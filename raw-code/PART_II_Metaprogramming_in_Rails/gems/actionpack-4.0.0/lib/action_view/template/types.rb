#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'set'
require 'active_support/core_ext/class/attribute_accessors'

module ActionView
  class Template
    class Types
      class Type
        cattr_accessor :types
        self.types = Set.new

        def self.register(*t)
          types.merge(t.map { |type| type.to_s })
        end

        register :html, :text, :js, :css,  :xml, :json

        def self.[](type)
          return type if type.is_a?(self)

          if type.is_a?(Symbol) || types.member?(type.to_s)
            new(type)
          end
        end

        attr_reader :symbol

        def initialize(symbol)
          @symbol = symbol.to_sym
        end

        delegate :to_s, :to_sym, :to => :symbol
        alias to_str to_s

        def ref
          to_sym || to_s
        end

        def ==(type)
          return false if type.blank?
          symbol.to_sym == type.to_sym
        end
      end

      cattr_accessor :type_klass

      def self.delegate_to(klass)
        self.type_klass = klass
      end

      delegate_to Type

      def self.[](type)
        type_klass[type]
      end
    end
  end
end
