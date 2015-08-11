#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/spec_helper'

describe "The square root" do
  (1..10).each do |n|
    it "of #{n*n} should be #{n}" do
      Math.sqrt(n*n).should == n
    end
  end
end
