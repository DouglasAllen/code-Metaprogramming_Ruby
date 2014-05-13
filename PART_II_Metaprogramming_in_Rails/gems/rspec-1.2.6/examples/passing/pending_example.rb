#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/spec_helper'

describe "pending example (using pending method)" do
  it %Q|should be reported as "PENDING: for some reason"| do
    pending("for some reason")
  end
end

describe "pending example (with no block)" do
  it %Q|should be reported as "PENDING: Not Yet Implemented"|
end

describe "pending example (with block for pending)" do
  it %Q|should have a failing block, passed to pending, reported as "PENDING: for some reason"| do
    pending("for some reason") do
      raise "some reason"
    end
  end
end

