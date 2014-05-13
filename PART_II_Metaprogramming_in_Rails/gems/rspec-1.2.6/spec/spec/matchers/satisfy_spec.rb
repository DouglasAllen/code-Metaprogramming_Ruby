#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper.rb'

describe "should satisfy { block }" do
  it "should pass if block returns true" do
    true.should satisfy { |val| val }
    true.should satisfy do |val|
      val
    end
  end

  it "should fail if block returns false" do
    lambda {
      false.should satisfy { |val| val }
    }.should fail_with("expected false to satisfy block")
    lambda do
      false.should satisfy do |val|
        val
      end
    end.should fail_with("expected false to satisfy block")
  end
end

describe "should_not satisfy { block }" do
  it "should pass if block returns false" do
    false.should_not satisfy { |val| val }
    false.should_not satisfy do |val|
      val
    end
  end

  it "should fail if block returns true" do
    lambda {
      true.should_not satisfy { |val| val }
    }.should fail_with("expected true not to satisfy block")
  end
end
