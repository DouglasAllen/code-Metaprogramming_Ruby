#!/usr/bin/env ruby
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


module Config

  # Only define datadir if it doesn't already exist.
  unless Config.respond_to?(:datadir)
    
    # Return the path to the data directory associated with the given
    # package name.  Normally this is just
    # "#{Config::CONFIG['datadir']}/#{package_name}", but may be
    # modified by packages like RubyGems to handle versioned data
    # directories.
    def Config.datadir(package_name)
      File.join(CONFIG['datadir'], package_name)
    end

  end
end
