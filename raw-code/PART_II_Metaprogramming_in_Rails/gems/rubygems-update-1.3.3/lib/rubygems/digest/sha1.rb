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

require 'digest/sha1'

# :stopdoc:
module Gem

  if RUBY_VERSION >= '1.8.6'
    SHA1 = Digest::SHA1
  else
    require 'rubygems/digest/digest_adapter'
    SHA1 = DigestAdapter.new(Digest::SHA1)
  end

end
# :startdoc:

