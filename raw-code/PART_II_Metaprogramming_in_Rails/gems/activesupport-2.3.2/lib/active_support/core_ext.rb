#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
Dir[File.dirname(__FILE__) + "/core_ext/*.rb"].sort.each do |path|
  filename = File.basename(path, '.rb')
  require "active_support/core_ext/#{filename}"
end
