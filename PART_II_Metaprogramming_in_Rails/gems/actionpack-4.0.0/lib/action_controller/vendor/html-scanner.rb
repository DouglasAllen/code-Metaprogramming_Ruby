#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'action_view/vendor/html-scanner'
require 'active_support/deprecation'

ActiveSupport::Deprecation.warn 'Vendored html-scanner was moved to action_view, please require "action_view/vendor/html-scanner" instead. ' +
                                'This file will be removed in Rails 4.1'
