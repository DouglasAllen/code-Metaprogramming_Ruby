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
    describe "PreciseCounts" do
      before(:each) do
        @mock = mock("test mock")
      end

      it "should fail when exactly n times method is called less than n times" do
        @mock.should_receive(:random_call).exactly(3).times
        @mock.random_call
        @mock.random_call
        lambda do
          @mock.rspec_verify
        end.should raise_error(MockExpectationError)
      end

      it "should fail when exactly n times method is never called" do
        @mock.should_receive(:random_call).exactly(3).times
        lambda do
          @mock.rspec_verify
        end.should raise_error(MockExpectationError)
      end

      it "should pass if exactly n times method is called exactly n times" do
        @mock.should_receive(:random_call).exactly(3).times
        @mock.random_call
        @mock.random_call
        @mock.random_call
        @mock.rspec_verify
      end

      it "should pass multiple calls with different args and counts" do
        @mock.should_receive(:random_call).twice.with(1)
        @mock.should_receive(:random_call).once.with(2)
        @mock.random_call(1)
        @mock.random_call(2)
        @mock.random_call(1)
        @mock.rspec_verify
      end

      it "should pass mutiple calls with different args" do
        @mock.should_receive(:random_call).once.with(1)
        @mock.should_receive(:random_call).once.with(2)
        @mock.random_call(1)
        @mock.random_call(2)
        @mock.rspec_verify
      end
    end
  end
end
