#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
# Common setup for all test files.

begin
  require 'rubygems'
  gem 'flexmock'
rescue LoadError
  # got no gems
end

require 'flexmock/test_unit'

if RUBY_VERSION >= "1.9.0"
  class Test::Unit::TestCase
#    def passed?
#      true
#    end
  end
end

module TestMethods
  def assert_exception(ex, msg=nil, &block)
    assert_raise(ex, msg, &block)
  end
end
