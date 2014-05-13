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
    module DSL
      # See Spec::Matchers
      def define(name, &declarations)
        define_method name do |*expected|
          Spec::Matchers::Matcher.new name, *expected, &declarations
        end
      end
      
      # Deprecated - use define
      def create(name, &declarations)
        Spec.deprecate("Spec::Matchers.create","Spec::Matchers.define")
        define(name, &declarations)
      end
    end
  end
end

Spec::Matchers.extend Spec::Matchers::DSL
