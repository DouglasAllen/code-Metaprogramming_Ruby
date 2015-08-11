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
  gem 'tmail', '~> 1.2.3'
rescue Gem::LoadError
  $:.unshift "#{File.dirname(__FILE__)}/tmail-1.2.3"
end

module TMail
end

require 'tmail'

silence_warnings do
  TMail::Encoder.const_set("MAX_LINE_LEN", 200)
end
