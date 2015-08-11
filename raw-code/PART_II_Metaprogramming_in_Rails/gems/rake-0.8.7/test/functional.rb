#!/usr/bin/env ruby
#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---

begin
  require 'rubygems'
  gem 'session'
  require 'session'
rescue LoadError
  puts "UNABLE TO RUN FUNCTIONAL TESTS"
  puts "No Session Found (gem install session)"
end

if defined?(Session)
  puts "RUNNING WITH SESSIONS"
  require 'test/session_functional'
end
