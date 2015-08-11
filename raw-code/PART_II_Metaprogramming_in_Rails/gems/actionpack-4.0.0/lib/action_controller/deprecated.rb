#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
ActionController::AbstractRequest = ActionController::Request = ActionDispatch::Request
ActionController::AbstractResponse = ActionController::Response = ActionDispatch::Response
ActionController::Routing = ActionDispatch::Routing

ActiveSupport::Deprecation.warn 'ActionController::AbstractRequest and ActionController::Request are deprecated and will be removed, use ActionDispatch::Request instead.'
ActiveSupport::Deprecation.warn 'ActionController::AbstractResponse and ActionController::Response are deprecated and will be removed, use ActionDispatch::Response instead.'
ActiveSupport::Deprecation.warn 'ActionController::Routing is deprecated and will be removed, use ActionDispatch::Routing instead.'