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
    describe "TwiceCounts" do
      before(:each) do
        @mock = mock("test mock")
      end

      it "twice should fail when call count is higher than expected" do
        @mock.should_receive(:random_call).twice
        @mock.random_call
        @mock.random_call
        @mock.random_call
        lambda do
          @mock.rspec_verify
        end.should raise_error(MockExpectationError)
      end
      
      it "twice should fail when call count is lower than expected" do
        @mock.should_receive(:random_call).twice
        @mock.random_call
        lambda do
          @mock.rspec_verify
        end.should raise_error(MockExpectationError)
      end
      
      it "twice should fail when called twice with wrong args on the first call" do
        @mock.should_receive(:random_call).twice.with("1", 1)
        lambda do
          @mock.random_call(1, "1")
        end.should raise_error(MockExpectationError)
        @mock.rspec_reset
      end
      
      it "twice should fail when called twice with wrong args on the second call" do
        @mock.should_receive(:random_call).twice.with("1", 1)
        @mock.random_call("1", 1)
        lambda do
          @mock.random_call(1, "1")
        end.should raise_error(MockExpectationError)
        @mock.rspec_reset
      end
      
      it "twice should pass when called twice" do
        @mock.should_receive(:random_call).twice
        @mock.random_call
        @mock.random_call
        @mock.rspec_verify
      end
      
      it "twice should pass when called twice with specified args" do
        @mock.should_receive(:random_call).twice.with("1", 1)
        @mock.random_call("1", 1)
        @mock.random_call("1", 1)
        @mock.rspec_verify
      end
      
      it "twice should pass when called twice with unspecified args" do
        @mock.should_receive(:random_call).twice
        @mock.random_call("1")
        @mock.random_call(1)
        @mock.rspec_verify
      end
    end
  end
end
