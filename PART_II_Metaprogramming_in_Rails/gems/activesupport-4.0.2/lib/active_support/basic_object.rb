#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/deprecation'
require 'active_support/proxy_object'

module ActiveSupport
  class BasicObject < ProxyObject # :nodoc:
    def self.inherited(*)
      ::ActiveSupport::Deprecation.warn 'ActiveSupport::BasicObject is deprecated! Use ActiveSupport::ProxyObject instead.'
      super
    end
  end
end
