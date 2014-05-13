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


require 'stringio'
require 'rubygems/user_interaction'

class MockGemUi < Gem::StreamUI
  class TermError < RuntimeError; end

  module TTY

    attr_accessor :tty

    def tty?()
      @tty = true unless defined?(@tty)
      @tty
    end

  end

  def initialize(input = "")
    ins = StringIO.new input
    outs = StringIO.new
    errs = StringIO.new

    ins.extend TTY
    outs.extend TTY
    errs.extend TTY

    super ins, outs, errs

    @terminated = false
  end

  def input
    @ins.string
  end

  def output
    @outs.string
  end

  def error
    @errs.string
  end

  def terminated?
    @terminated
  end

  def terminate_interaction(status=0)
    @terminated = true

    raise TermError unless status == 0
    raise Gem::SystemExitException, status
  end

end

