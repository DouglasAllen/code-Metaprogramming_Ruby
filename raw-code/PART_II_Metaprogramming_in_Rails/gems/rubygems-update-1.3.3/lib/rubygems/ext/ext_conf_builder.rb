#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
#--
# Copyright 2006 by Chad Fowler, Rich Kilmer, Jim Weirich and others.
# All rights reserved.
# See LICENSE.txt for permissions.
#++

require 'rubygems/ext/builder'
require 'rubygems/command'

class Gem::Ext::ExtConfBuilder < Gem::Ext::Builder

  def self.build(extension, directory, dest_path, results)
    cmd = "#{Gem.ruby} #{File.basename extension}"
    cmd << " #{Gem::Command.build_args.join ' '}" unless Gem::Command.build_args.empty?

    run cmd, results

    make dest_path, results

    results
  end

end

