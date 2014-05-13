#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require "utils"
require 'capistrano/recipes/deploy/scm/accurev'

class AccurevTest < Test::Unit::TestCase
  include Capistrano::Deploy::SCM

  def test_internal_revision_to_s
    assert_equal 'foo/1', Accurev::InternalRevision.new('foo', 1).to_s
    assert_equal 'foo/highest', Accurev::InternalRevision.new('foo', 'highest').to_s
  end

  def test_internal_revision_parse
    revision = Accurev::InternalRevision.parse('foo')
    assert_equal 'foo', revision.stream
    assert_equal 'highest', revision.transaction_id
    assert_equal 'foo/highest', revision.to_s

    revision = Accurev::InternalRevision.parse('foo/1')
    assert_equal 'foo', revision.stream
    assert_equal '1', revision.transaction_id
    assert_equal 'foo/1', revision.to_s
  end
end
