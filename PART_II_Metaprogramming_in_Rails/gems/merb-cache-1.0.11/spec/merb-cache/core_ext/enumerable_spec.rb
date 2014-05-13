#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper'

describe Enumerable do
  describe "#capture_first" do
    it "should return the result of the first block call that is non-nil, not the item sent to the block" do
      [1, 2, 3].capture_first {|i| i ** i if i % 2 == 0}.should == 4
    end

    it "should return nil if all block calls are nil" do
      [1, 2, 3].capture_first {|i| nil }.should be_nil
    end

    it "should stop calling the block once a block evaluates to non-nil" do
      lambda {
        [1, 2, 3].capture_first do |i|
          raise "#{i} is divisible by 3!" if i % 3 == 0
          i ** i if i % 2 == 0
        end
      }.should_not raise_error
    end
  end
end