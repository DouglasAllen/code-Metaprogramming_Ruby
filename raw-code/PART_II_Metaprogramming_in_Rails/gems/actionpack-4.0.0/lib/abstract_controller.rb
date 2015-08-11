#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'action_pack'
require 'active_support/rails'
require 'active_support/core_ext/module/attr_internal'
require 'active_support/core_ext/module/anonymous'
require 'active_support/i18n'

module AbstractController
  extend ActiveSupport::Autoload

  autoload :Base
  autoload :Callbacks
  autoload :Collector
  autoload :Helpers
  autoload :Layouts
  autoload :Logger
  autoload :Rendering
  autoload :Translation
  autoload :AssetPaths
  autoload :ViewPaths
  autoload :UrlFor
end
