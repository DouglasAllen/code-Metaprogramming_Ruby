#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActionView
  module ModelNaming
    # Converts the given object to an ActiveModel compliant one.
    def convert_to_model(object)
      object.respond_to?(:to_model) ? object.to_model : object
    end

    def model_name_from_record_or_class(record_or_class)
      (record_or_class.is_a?(Class) ? record_or_class : convert_to_model(record_or_class).class).model_name
    end
  end
end
