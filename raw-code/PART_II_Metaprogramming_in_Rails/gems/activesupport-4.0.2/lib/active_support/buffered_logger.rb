#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/deprecation'
require 'active_support/logger'

module ActiveSupport
  class BufferedLogger < Logger

    def initialize(*args)
      self.class._deprecation_warning
      super
    end

    def self.inherited(*)
      _deprecation_warning
      super
    end

    def self._deprecation_warning
      ::ActiveSupport::Deprecation.warn 'ActiveSupport::BufferedLogger is deprecated! Use ActiveSupport::Logger instead.'
    end
  end
end
