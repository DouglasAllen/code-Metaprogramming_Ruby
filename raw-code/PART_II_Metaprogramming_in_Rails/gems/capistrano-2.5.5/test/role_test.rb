#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require "utils"
require 'capistrano/role'

class RoleTest < Test::Unit::TestCase
  def test_clearing_a_populated_role_should_yield_no_servers
    role = Capistrano::Role.new("app1.capistrano.test", lambda { |o| "app2.capistrano.test" })
    assert_equal 2, role.servers.size
    role.clear
    assert role.servers.empty?
  end
end
