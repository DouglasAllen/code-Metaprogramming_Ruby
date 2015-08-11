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
      module Checkable # :nodoc:
        def input_checked?(object, options)
          if options.has_key?("checked")
            checked = options.delete "checked"
            checked == true || checked == "checked"
          else
            checked?(value(object))
          end
        end
      end
    end
  end
end
