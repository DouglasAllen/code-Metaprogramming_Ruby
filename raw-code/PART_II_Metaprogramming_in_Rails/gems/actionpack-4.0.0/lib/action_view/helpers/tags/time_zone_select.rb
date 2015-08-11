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
      class TimeZoneSelect < Base # :nodoc:
        def initialize(object_name, method_name, template_object, priority_zones, options, html_options)
          @priority_zones = priority_zones
          @html_options   = html_options

          super(object_name, method_name, template_object, options)
        end

        def render
          select_content_tag(
            time_zone_options_for_select(value(@object) || @options[:default], @priority_zones, @options[:model] || ActiveSupport::TimeZone), @options, @html_options
          )
        end
      end
    end
  end
end
