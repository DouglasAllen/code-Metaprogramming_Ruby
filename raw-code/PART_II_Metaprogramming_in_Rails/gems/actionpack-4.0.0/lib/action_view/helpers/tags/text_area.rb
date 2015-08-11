#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActionView
  module Helpers
    module Tags # :nodoc:
      class TextArea < Base # :nodoc:
        def render
          options = @options.stringify_keys
          add_default_name_and_id(options)

          if size = options.delete("size")
            options["cols"], options["rows"] = size.split("x") if size.respond_to?(:split)
          end

          content_tag("textarea", options.delete('value') || value_before_type_cast(object), options)
        end
      end
    end
  end
end
