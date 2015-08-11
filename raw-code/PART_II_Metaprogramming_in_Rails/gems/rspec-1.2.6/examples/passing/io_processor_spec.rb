#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/io_processor'
require 'stringio'

describe "An IoProcessor" do
  before(:each) do
    @processor = IoProcessor.new
  end

  it "should raise nothing when the file is exactly 32 bytes" do
    lambda {
      @processor.process(StringIO.new("z"*32))
    }.should_not raise_error
  end

  it "should raise an exception when the file length is less than 32 bytes" do
    lambda {
      @processor.process(StringIO.new("z"*31))
    }.should raise_error(DataTooShort)
  end
end
