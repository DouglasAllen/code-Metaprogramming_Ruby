#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Rails
  module Rack
    autoload :Debugger, "rails/rack/debugger"
    autoload :LogTailer, "rails/rack/log_tailer"
    autoload :Metal, "rails/rack/metal"
    autoload :Static, "rails/rack/static"
  end
end
