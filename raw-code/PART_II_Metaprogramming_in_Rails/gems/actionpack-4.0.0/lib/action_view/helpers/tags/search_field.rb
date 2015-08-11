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
      class SearchField < TextField # :nodoc:
        def render
          options = @options.stringify_keys

          if options["autosave"]
            if options["autosave"] == true
              options["autosave"] = request.host.split(".").reverse.join(".")
            end
            options["results"] ||= 10
          end

          if options["onsearch"]
            options["incremental"] = true unless options.has_key?("incremental")
          end

          super
        end
      end
    end
  end
end
