#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'rubygems/command'
require 'rubygems/local_remote_options'
require 'rubygems/spec_fetcher'
require 'rubygems/version_option'

class Gem::Commands::OutdatedCommand < Gem::Command

  include Gem::LocalRemoteOptions
  include Gem::VersionOption

  def initialize
    super 'outdated', 'Display all gems that need updates'

    add_local_remote_options
    add_platform_option
  end

  def execute
    locals = Gem::SourceIndex.from_installed_gems

    locals.outdated.sort.each do |name|
      local = locals.find_name(name).last

      dep = Gem::Dependency.new local.name, ">= #{local.version}"
      remotes = Gem::SpecFetcher.fetcher.fetch dep
      remote = remotes.last.first

      say "#{local.name} (#{local.version} < #{remote.version})"
    end
  end

end

