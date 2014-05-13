#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/../../../spec_helper.rb'

describe Object, "#should" do
  before(:each) do
    @target = "target"
    @matcher = mock("matcher")
    @matcher.stub!(:matches?).and_return(true)
    @matcher.stub!(:failure_message_for_should)
  end
  
  it "accepts and interacts with a matcher" do
    @matcher.should_receive(:matches?).with(@target).and_return(true)    
    @target.should @matcher
  end
  
  it "asks for a failure_message_for_should when matches? returns false" do
    @matcher.should_receive(:matches?).with(@target).and_return(false)
    @matcher.should_receive(:failure_message_for_should).and_return("the failure message")
    lambda {
      @target.should @matcher
    }.should fail_with("the failure message")
  end
end

describe Object, "#should_not" do
  before(:each) do
    @target = "target"
    @matcher = mock("matcher")
  end
  
  it "accepts and interacts with a matcher" do
    @matcher.should_receive(:matches?).with(@target).and_return(false)
    @matcher.stub!(:failure_message_for_should_not)
    
    @target.should_not @matcher
  end
  
  it "asks for a failure_message_for_should_not when matches? returns true" do
    @matcher.should_receive(:matches?).with(@target).and_return(true)
    @matcher.should_receive(:failure_message_for_should_not).and_return("the failure message for should not")
    lambda {
      @target.should_not @matcher
    }.should fail_with("the failure message for should not")
  end
end
