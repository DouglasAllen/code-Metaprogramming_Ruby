#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.join(File.expand_path(File.dirname(__FILE__)), 'gemutilities')
require 'rubygems/command'
require 'rubygems/version_option'

class TestGemVersionOption < RubyGemTestCase

  def setup
    super

    @cmd = Gem::Command.new 'dummy', 'dummy'
    @cmd.extend Gem::VersionOption
  end

  def test_add_platform_option
    @cmd.add_platform_option

    assert @cmd.handles?(%w[--platform x86-darwin])
  end

  def test_add_version_option
    @cmd.add_version_option

    assert @cmd.handles?(%w[--version >1])
  end

  def test_enables_prerelease
    @cmd.add_version_option

    @cmd.handle_options %w[mygem -v 0.2.0.a]
    assert @cmd.options[:prerelease]

    @cmd.handle_options %w[mygem -v 0.2.0]
    refute @cmd.options[:prerelease]

    @cmd.handle_options %w[mygem]
    refute @cmd.options[:prerelease]
  end

  def test_platform_option
    @cmd.add_platform_option

    @cmd.handle_options %w[--platform x86-freebsd6 --platform x86-freebsd7]

    expected = [
      Gem::Platform::RUBY,
      Gem::Platform.new('x86-freebsd6'),
      Gem::Platform.new('x86-freebsd7'),
    ]

    assert_equal expected, Gem.platforms
  end

  def test_platform_option_ruby
    @cmd.add_platform_option

    @cmd.handle_options %w[--platform ruby]

    expected = [
      Gem::Platform::RUBY
    ]

    assert_equal expected, Gem.platforms
  end

  def test_platform_option_twice
    @cmd.add_platform_option

    @cmd.handle_options %w[--platform x86-freebsd6 --platform x86-freebsd-6]

    expected = [
      Gem::Platform::RUBY,
      Gem::Platform.new('x86-freebsd6'),
    ]

    assert_equal expected, Gem.platforms
  end

  def test_version_option
    @cmd.add_version_option

    @cmd.handle_options %w[--version >1]

    expected = { :version => Gem::Requirement.new('> 1'), :args => [] }

    assert_equal expected, @cmd.options
  end

end

