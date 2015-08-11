#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'rubygems/command'

class Gem::Commands::StaleCommand < Gem::Command
  def initialize
    super('stale', 'List gems along with access times')
  end

  def usage # :nodoc:
    "#{program_name}"
  end

  def execute
    gem_to_atime = {}
    Gem.source_index.each do |name, spec|
      Dir["#{spec.full_gem_path}/**/*.*"].each do |file|
        next if File.directory?(file)
        stat = File.stat(file)
        gem_to_atime[name] ||= stat.atime
        gem_to_atime[name] = stat.atime if gem_to_atime[name] < stat.atime
      end
    end

    gem_to_atime.sort_by { |_, atime| atime }.each do |name, atime|
      say "#{name} at #{atime.strftime '%c'}"
    end
  end
end
