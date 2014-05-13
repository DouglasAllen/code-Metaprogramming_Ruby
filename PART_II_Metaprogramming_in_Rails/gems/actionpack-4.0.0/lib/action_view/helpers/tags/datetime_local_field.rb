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
      class DatetimeLocalField < DatetimeField # :nodoc:
        class << self
          def field_type
            @field_type ||= "datetime-local"
          end
        end

        private

          def format_date(value)
            value.try(:strftime, "%Y-%m-%dT%T")
          end
      end
    end
  end
end
