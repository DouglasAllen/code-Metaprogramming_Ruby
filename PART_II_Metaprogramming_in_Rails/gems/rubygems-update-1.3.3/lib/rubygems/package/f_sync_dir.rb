#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
#++
# Copyright (C) 2004 Mauricio Julio Fernández Pradier
# See LICENSE.txt for additional licensing information.
#--

require 'rubygems/package'

module Gem::Package::FSyncDir

  private

  ##
  # make sure this hits the disc

  def fsync_dir(dirname)
    dir = open dirname, 'r'
    dir.fsync
  rescue # ignore IOError if it's an unpatched (old) Ruby
  ensure
    dir.close if dir rescue nil
  end

end

