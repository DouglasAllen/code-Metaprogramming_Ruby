#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require "utils"
require 'capistrano/cli/ui'

class CLIUITest < Test::Unit::TestCase
  class MockCLI
    include Capistrano::CLI::UI
  end

  def test_ui_should_return_highline_instance
    assert_instance_of HighLine, MockCLI.ui
  end

  def test_password_prompt_should_have_default_prompt_and_set_echo_false
    q = mock("question")
    q.expects(:echo=).with(false)
    ui = mock("ui")
    ui.expects(:ask).with("Password: ").yields(q).returns("sayuncle")
    MockCLI.expects(:ui).returns(ui)
    assert_equal "sayuncle", MockCLI.password_prompt
  end

  def test_password_prompt_with_custom_prompt_should_use_custom_prompt
    ui = mock("ui")
    ui.expects(:ask).with("Give the passphrase: ").returns("sayuncle")
    MockCLI.expects(:ui).returns(ui)
    assert_equal "sayuncle", MockCLI.password_prompt("Give the passphrase: ")
  end
end