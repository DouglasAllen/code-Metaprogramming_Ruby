#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/core_ext/range/conversions'
require 'active_support/core_ext/range/overlaps'
require 'active_support/core_ext/range/include_range'
require 'active_support/core_ext/range/blockless_step'

class Range #:nodoc:
  include ActiveSupport::CoreExtensions::Range::Conversions
  include ActiveSupport::CoreExtensions::Range::Overlaps
  include ActiveSupport::CoreExtensions::Range::IncludeRange
  include ActiveSupport::CoreExtensions::Range::BlocklessStep
end
