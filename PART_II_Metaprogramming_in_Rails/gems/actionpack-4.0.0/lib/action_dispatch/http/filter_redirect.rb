#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActionDispatch
  module Http
    module FilterRedirect

      FILTERED = '[FILTERED]'.freeze # :nodoc:

      def filtered_location
        if !location_filter.empty? && location_filter_match?
          FILTERED
        else
          location
        end
      end

    private

      def location_filter
        if request.present?
          request.env['action_dispatch.redirect_filter'] || []
        else
          []
        end
      end

      def location_filter_match?
        location_filter.any? do |filter|
          if String === filter
            location.include?(filter)
          elsif Regexp === filter
            location.match(filter)
          end
        end
      end

    end
  end
end
