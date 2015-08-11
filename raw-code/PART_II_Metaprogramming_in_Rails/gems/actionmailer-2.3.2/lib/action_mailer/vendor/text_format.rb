#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
# Prefer gems to the bundled libs.
require 'rubygems'

begin
  gem 'text-format', '>= 0.6.3'
rescue Gem::LoadError
  $:.unshift "#{File.dirname(__FILE__)}/text-format-0.6.3"
end

require 'text/format'
