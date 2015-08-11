#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'rubygems'

module Gem::RequirePathsBuilder
  def write_require_paths_file_if_needed(spec = @spec, gem_home = @gem_home)
    return if spec.require_paths == ["lib"] &&
              (spec.bindir.nil? || spec.bindir == "bin")
    file_name = File.join(gem_home, 'gems', "#{@spec.full_name}", ".require_paths")
    file_name.untaint
    File.open(file_name, "w") do |file|
      spec.require_paths.each do |path|
        file.puts path
      end
      file.puts spec.bindir if spec.bindir
    end
  end
end

