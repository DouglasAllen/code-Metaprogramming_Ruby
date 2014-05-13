#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/deprecation'

module ActiveSupport
  module Testing
    module Pending # :nodoc:
      unless defined?(Spec) 
        def pending(description = "", &block)
          ActiveSupport::Deprecation.warn("#pending is deprecated and will be removed in Rails 4.1, please use #skip instead.")
          skip(description.blank? ? nil : description)
        end
      end
    end
  end
end
