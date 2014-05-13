#!/usr/bin/env ruby
#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---

require 'test/unit'
require 'rake/tasklib'


class TestTaskLib < Test::Unit::TestCase
  def test_paste
    tl = Rake::TaskLib.new
    assert_equal :ab, tl.paste(:a, :b)
  end
end
