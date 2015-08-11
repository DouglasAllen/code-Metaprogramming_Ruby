#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.join(File.expand_path(File.dirname(__FILE__)), 'gemutilities')
require 'rubygems/gem_runner'

class TestGemGemRunner < RubyGemTestCase

  def test_do_configuration
    Gem.clear_paths

    temp_conf = File.join @tempdir, '.gemrc'

    other_gem_path = File.join @tempdir, 'other_gem_path'
    other_gem_home = File.join @tempdir, 'other_gem_home'

    Gem.ensure_gem_subdirectories other_gem_path
    Gem.ensure_gem_subdirectories other_gem_home

    File.open temp_conf, 'w' do |fp|
      fp.puts "gem: --commands"
      fp.puts "gemhome: #{other_gem_home}"
      fp.puts "gempath:"
      fp.puts "  - #{other_gem_path}"
      fp.puts "rdoc: --all"
    end

    gr = Gem::GemRunner.new
    gr.send :do_configuration, %W[--config-file #{temp_conf}]

    assert_equal [other_gem_path, other_gem_home], Gem.path
    assert_equal %w[--commands], Gem::Command.extra_args
    assert_equal %w[--all], Gem::DocManager.configured_args
  end

  def test_build_args__are_handled
    Gem.clear_paths

    gr = Gem::GemRunner.new
    assert_raises(Gem::SystemExitException) do
      gr.run(%W[--help -- --build_arg1 --build_arg2])
    end

    assert_equal %w[--build_arg1 --build_arg2], Gem::Command.build_args
  end

end

