#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'action_view/helpers/tags/checkable'

module ActionView
  module Helpers
    module Tags # :nodoc:
      class RadioButton < Base # :nodoc:
        include Checkable

        def initialize(object_name, method_name, template_object, tag_value, options)
          @tag_value = tag_value
          super(object_name, method_name, template_object, options)
        end

        def render
          options = @options.stringify_keys
          options["type"]     = "radio"
          options["value"]    = @tag_value
          options["checked"] = "checked" if input_checked?(object, options)
          add_default_name_and_id_for_value(@tag_value, options)
          tag("input", options)
        end

        private

        def checked?(value)
          value.to_s == @tag_value.to_s
        end
      end
    end
  end
end
