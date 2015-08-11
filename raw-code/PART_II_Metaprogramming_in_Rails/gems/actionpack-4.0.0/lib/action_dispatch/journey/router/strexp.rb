#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActionDispatch
  module Journey # :nodoc:
    class Router # :nodoc:
      class Strexp # :nodoc:
        class << self
          alias :compile :new
        end

        attr_reader :path, :requirements, :separators, :anchor

        def initialize(path, requirements, separators, anchor = true)
          @path         = path
          @requirements = requirements
          @separators   = separators
          @anchor       = anchor
        end

        def names
          @path.scan(/:\w+/).map { |s| s.tr(':', '') }
        end
      end
    end
  end
end
