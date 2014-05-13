#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require "test/unit"
$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib') 
require "ruport"
begin; require "rubygems"; rescue LoadError; nil; end
require "spec-unit"
require "mocha"
require "stubba"

class Test::Unit::TestCase
  include SpecUnit
end