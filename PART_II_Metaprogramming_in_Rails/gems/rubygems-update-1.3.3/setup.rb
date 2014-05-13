#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
#--
# Copyright 2006, 2007 by Chad Fowler, Rich Kilmer, Jim Weirich, Eric Hodel
# and others.
# All rights reserved.
# See LICENSE.txt for permissions.
#++

# Make sure rubygems isn't already loaded.
if ENV['RUBYOPT'] and defined? Gem then
  ENV.delete 'RUBYOPT'

  require 'rbconfig'
  config = defined?(RbConfig) ? RbConfig : Config

  ruby = File.join config::CONFIG['bindir'], config::CONFIG['ruby_install_name']
  ruby << config::CONFIG['EXEEXT']

  exec(ruby, 'setup.rb', *ARGV)
end

Dir.chdir File.dirname(__FILE__)

$:.unshift 'lib'
require 'rubygems'
require 'rubygems/gem_runner'
require 'rubygems/exceptions'

Gem::CommandManager.instance.register_command :setup

args = ARGV.clone

args.unshift 'setup'

begin
  Gem::GemRunner.new.run args
rescue Gem::SystemExitException => e
  exit e.exit_code
end

