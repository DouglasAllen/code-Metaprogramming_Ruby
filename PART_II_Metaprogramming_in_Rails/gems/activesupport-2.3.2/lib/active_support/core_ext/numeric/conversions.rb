#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module Numeric #:nodoc:
      module Conversions
        # Assumes self represents an offset from UTC in seconds (as returned from Time#utc_offset)
        # and turns this into an +HH:MM formatted string. Example:
        #
        #   -21_600.to_utc_offset_s   # => "-06:00"
        def to_utc_offset_s(colon=true)
          seconds = self
          sign = (seconds < 0 ? -1 : 1)
          hours = seconds.abs / 3600
          minutes = (seconds.abs % 3600) / 60
          "%+03d%s%02d" % [ hours * sign, colon ? ":" : "", minutes ]
        end
      end
    end
  end
end
