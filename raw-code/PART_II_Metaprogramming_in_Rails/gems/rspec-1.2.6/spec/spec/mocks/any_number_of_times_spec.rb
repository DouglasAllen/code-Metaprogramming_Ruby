#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper.rb'

module Spec
  module Mocks
    
    describe "AnyNumberOfTimes" do
      before(:each) do
        @mock = Mock.new("test mock")
      end

      it "should pass if any number of times method is called many times" do
        @mock.should_receive(:random_call).any_number_of_times
        (1..10).each do
          @mock.random_call
        end
      end

      it "should pass if any number of times method is called once" do
        @mock.should_receive(:random_call).any_number_of_times
        @mock.random_call
      end
      
      it "should pass if any number of times method is not called" do
        @mock.should_receive(:random_call).any_number_of_times
      end

      it "should return the mocked value when called after a similar stub" do
        @mock.stub!(:message).and_return :stub_value
        @mock.should_receive(:message).any_number_of_times.and_return(:mock_value)
        @mock.message.should == :mock_value
        @mock.message.should == :mock_value
      end
    end

  end
end
