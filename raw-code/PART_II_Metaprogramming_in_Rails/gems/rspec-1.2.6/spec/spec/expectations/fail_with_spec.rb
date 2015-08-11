#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper.rb'

describe Spec::Expectations, "#fail_with with no diff" do
  before(:each) do
    @old_differ = Spec::Expectations.differ
    Spec::Expectations.differ = nil
  end
  
  it "should handle just a message" do
    lambda {
      Spec::Expectations.fail_with "the message"
    }.should fail_with("the message")
  end
  
  after(:each) do
    Spec::Expectations.differ = @old_differ
  end
end

describe Spec::Expectations, "#fail_with with Array" do
  before(:each) do
    Spec.stub!(:warn)
  end
  
  it "is deprecated" do
    Spec.should_receive(:warn)
    lambda {
      Spec::Expectations.fail_with ["message", "expected", "actual"]
    }.should raise_error
  end
end

describe Spec::Expectations, "#fail_with with diff" do
  before(:each) do
    @old_differ = Spec::Expectations.differ
    @differ = mock("differ")
    Spec::Expectations.differ = @differ
  end
  
  it "should not call differ if no expected/actual" do
    lambda {
      Spec::Expectations.fail_with "the message"
    }.should fail_with("the message")
  end
  
  it "should call differ if expected/actual are presented separately" do
    @differ.should_receive(:diff_as_string).and_return("diff")
    lambda {
      Spec::Expectations.fail_with "the message", "expected", "actual"
    }.should fail_with("the message\nDiff:diff")
  end
  
  it "should call differ if expected/actual are not strings" do
    @differ.should_receive(:diff_as_object).and_return("diff")
    lambda {
      Spec::Expectations.fail_with "the message", :expected, :actual
    }.should fail_with("the message\nDiff:diff")
  end
  
  it "should not call differ if expected or actual are procs" do
    @differ.should_not_receive(:diff_as_string)
    @differ.should_not_receive(:diff_as_object)
    lambda {
      Spec::Expectations.fail_with "the message", lambda {}, lambda {}
    }.should fail_with("the message")
  end
  
  after(:each) do
    Spec::Expectations.differ = @old_differ
  end
end
