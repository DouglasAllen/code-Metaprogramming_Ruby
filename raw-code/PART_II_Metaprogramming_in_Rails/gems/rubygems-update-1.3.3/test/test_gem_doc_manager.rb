#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
#--
# Copyright 2006 by Chad Fowler, Rich Kilmer, Jim Weirich and others.
# All rights reserved.
# See LICENSE.txt for permissions.
#++

require File.join(File.expand_path(File.dirname(__FILE__)), 'gemutilities')
require 'rubygems/doc_manager'

class TestGemDocManager < RubyGemTestCase

  def setup
    super

    @spec = quick_gem 'a'
    @manager = Gem::DocManager.new(@spec)
  end

  def test_uninstall_doc_unwritable
    orig_mode = File.stat(@spec.installation_path).mode
    
    # File.chmod has no effect on MS Windows directories (it needs ACL).
    if win_platform?
      skip("test_uninstall_doc_unwritable skipped on MS Windows")
    else
      File.chmod(0, @spec.installation_path)
    end

    assert_raises Gem::FilePermissionError do
      @manager.uninstall_doc
    end
  ensure
    File.chmod orig_mode, @spec.installation_path
  end

end

