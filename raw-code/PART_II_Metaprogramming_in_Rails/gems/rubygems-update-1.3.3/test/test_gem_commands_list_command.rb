#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.join(File.expand_path(File.dirname(__FILE__)), 'gemutilities')
require 'rubygems/commands/list_command'

class TestGemCommandsListCommand < RubyGemTestCase

  def setup
    super

    @cmd = Gem::Commands::ListCommand.new

    util_setup_fake_fetcher

    @si = util_setup_spec_fetcher @a1, @a2, @pl1

    @fetcher.data["#{@gem_repo}Marshal.#{Gem.marshal_version}"] = proc do
      raise Gem::RemoteFetcher::FetchError
    end
  end

  def test_execute_installed
    @cmd.handle_options %w[c --installed]

    e = assert_raises Gem::SystemExitException do
      use_ui @ui do
        @cmd.execute
      end
    end

    assert_equal 0, e.exit_code

    assert_equal "true\n", @ui.output

    assert_equal '', @ui.error
  end

end
