#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'utils'
require 'capistrano/recipes/deploy/scm/none'

class DeploySCMNoneTest < Test::Unit::TestCase
  class TestSCM < Capistrano::Deploy::SCM::None
    default_command 'none'
  end

  def setup
    @config = {}
    def @config.exists?(name); key?(name); end
    @source = TestSCM.new(@config)
  end

  def test_the_truth
    assert true
  end

  def test_checkout_on_linux
    Capistrano::Deploy::LocalDependency.stubs(:on_windows?).returns(false)
    @config[:repository] = '.'
    rev = ''
    dest = '/var/www'
    assert_equal "cp -R . /var/www", @source.checkout(rev, dest)
  end

  def test_checkout_on_windows
    Capistrano::Deploy::LocalDependency.stubs(:on_windows?).returns(true)
    @config[:repository] = '.'
    rev = ''
    dest = 'c:/Documents and settings/admin/tmp'
    assert_equal "xcopy . \"c:/Documents and settings/admin/tmp\" /S/I/Y/Q/E", @source.checkout(rev, dest)
  end

end
