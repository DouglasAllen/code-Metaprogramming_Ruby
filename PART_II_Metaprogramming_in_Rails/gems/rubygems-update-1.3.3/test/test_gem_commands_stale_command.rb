#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.join(File.expand_path(File.dirname(__FILE__)), 'gemutilities')
require 'rubygems/commands/stale_command'

class TestGemCommandsStaleCommand < RubyGemTestCase

  def setup
    super
    @cmd = Gem::Commands::StaleCommand.new
  end

  def test_execute_sorts
    files = %w[lib/foo_bar.rb Rakefile]
    foo_bar = quick_gem 'foo_bar' do |gem|
      gem.files = files
    end
    bar_baz = quick_gem 'bar_baz' do |gem|
      gem.files = files
    end

    files.each do |file|
      filename = bar_baz.full_gem_path + "/#{file}"
      FileUtils.mkdir_p(File.dirname(filename))
      FileUtils.touch(filename, :mtime => Time.now)

      filename = foo_bar.full_gem_path + "/#{file}"
      FileUtils.mkdir_p(File.dirname(filename))
      FileUtils.touch(filename, :mtime => Time.now - 86400)
    end

    use_ui @ui do
      @cmd.execute
    end
    lines = @ui.output.split("\n")
    assert_equal("#{foo_bar.name}-#{foo_bar.version}", lines[0].split.first)
    assert_equal("#{bar_baz.name}-#{bar_baz.version}", lines[1].split.first)
  end

end
