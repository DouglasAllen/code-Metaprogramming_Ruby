#!/usr/bin/env ruby
#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# encoding: iso-8859-1

#--
# Portions copyright 2004 by Jim Weirich (jim@weirichhouse.org).
# Portions copyright 2005 by Sam Ruby (rubys@intertwingly.net).
# All rights reserved.

# Permission is granted for use, copying, modification, distribution,
# and distribution of modified versions of this work as long as the
# above copyright notice is included.
#++

require 'builder/xmlmarkup'
require 'benchmark'

text = "This is a test of the new xml markup. I�t�rn�ti�n�liz�ti�n\n" * 10000

include Benchmark          # we need the CAPTION and FMTSTR constants
include Builder
n = 50
Benchmark.benchmark do |bm|
  tf = bm.report("base")   {
    n.times do
      x = XmlMarkup.new
      x.text(text)
      x.target!
    end
  }
  def XmlMarkup._escape(text)
    text.to_xs
  end
  tf = bm.report("to_xs")   {
    n.times do
      x = XmlMarkup.new
      x.text(text)
      x.target!
    end
  }
end

