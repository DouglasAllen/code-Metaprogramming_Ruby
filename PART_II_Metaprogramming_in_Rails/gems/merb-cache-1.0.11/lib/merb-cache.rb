#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
# make sure we're running inside Merb
if defined?(Merb::Plugins)
  require "merb-cache" / "cache"
  require "merb-cache" / "core_ext" / "enumerable"
  require "merb-cache" / "core_ext" / "hash"
  require "merb-cache" / "merb_ext" / "controller"
  require "merb-cache" / "cache_request"

  class Merb::Controller
    include Merb::Cache::CacheMixin
  end
end
