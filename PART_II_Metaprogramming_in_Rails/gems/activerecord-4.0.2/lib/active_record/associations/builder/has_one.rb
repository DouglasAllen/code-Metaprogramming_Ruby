#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveRecord::Associations::Builder
  class HasOne < SingularAssociation #:nodoc:
    def macro
      :has_one
    end

    def valid_options
      valid = super + [:order, :as]
      valid += [:through, :source, :source_type] if options[:through]
      valid
    end

    def constructable?
      !options[:through]
    end

    def configure_dependency
      super unless options[:through]
    end

    def valid_dependent_options
      [:destroy, :delete, :nullify, :restrict, :restrict_with_error, :restrict_with_exception]
    end
  end
end
