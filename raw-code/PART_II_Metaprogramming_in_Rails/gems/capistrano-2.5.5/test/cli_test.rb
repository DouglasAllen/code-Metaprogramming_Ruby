#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require "utils"
require 'capistrano/cli'

class CLI_Test < Test::Unit::TestCase
  def test_options_ui_and_help_modules_should_integrate_successfully_with_configuration
    cli = Capistrano::CLI.parse(%w(-T))
    cli.expects(:puts).at_least_once
    cli.execute!
  end

  def test_options_and_execute_modules_should_integrate_successfully_with_configuration
    path = "#{File.dirname(__FILE__)}/fixtures/cli_integration.rb"
    cli = Capistrano::CLI.parse(%W(-q -f #{path} testing))
    config = cli.execute!
    assert config[:testing_occurred]
  end
end
