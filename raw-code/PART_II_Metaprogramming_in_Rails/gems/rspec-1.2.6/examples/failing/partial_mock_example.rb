#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/spec_helper'

class MockableClass
  def self.find id
    return :original_return
  end
end

describe "A partial mock" do

  it "should work at the class level (but fail here due to the type mismatch)" do
    MockableClass.should_receive(:find).with(1).and_return {:stub_return}
    MockableClass.find("1").should equal(:stub_return)
  end

  it "should revert to the original after each spec" do
    MockableClass.find(1).should equal(:original_return)
  end

end
