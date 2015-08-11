#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
#:stopdoc:
unless Object.respond_to?(:blank?)
  class Object
    # Check first to see if we are in a Rails environment, no need to 
    # define these methods if we are

    # An object is blank if it's nil, empty, or a whitespace string.
    # For example, "", "   ", nil, [], and {} are blank.
    #
    # This simplifies
    #   if !address.nil? && !address.empty?
    # to
    #   if !address.blank?
    def blank?
      if respond_to?(:empty?) && respond_to?(:strip)
        empty? or strip.empty?
      elsif respond_to?(:empty?)
        empty?
      else
        !self
      end
    end
  end

  class NilClass
    def blank?
      true
    end
  end

  class FalseClass
    def blank?
      true
    end
  end

  class TrueClass
    def blank?
      false
    end
  end

  class Array
    alias_method :blank?, :empty?
  end

  class Hash
    alias_method :blank?, :empty?
  end

  class String
    def blank?
      empty? || strip.empty?
    end
  end

  class Numeric
    def blank?
      false
    end
  end
end
#:startdoc: