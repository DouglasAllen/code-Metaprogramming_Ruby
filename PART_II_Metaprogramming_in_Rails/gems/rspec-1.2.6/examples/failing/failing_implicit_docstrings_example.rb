#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/spec_helper'

# Run spec w/ -fs to see the output of this file

describe "Failing examples with no descriptions" do

  # description is auto-generated as "should equal(5)" based on the last #should
  it do
    3.should equal(2)
    5.should equal(5)
  end

  it { 3.should be > 5 }

  it { ["a"].should include("b") }

  it { [1,2,3].should_not respond_to(:size) }

end
