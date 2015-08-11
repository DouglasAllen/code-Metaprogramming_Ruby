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
    describe "OnceCounts" do
      before(:each) do
        @mock = mock("test mock")
      end

      it "once should fail when called once with wrong args" do
        @mock.should_receive(:random_call).once.with("a", "b", "c")
        lambda do
          @mock.random_call("d", "e", "f")
        end.should raise_error(MockExpectationError)
        @mock.rspec_reset
      end

      it "once should fail when called twice" do
        @mock.should_receive(:random_call).once
        @mock.random_call
        @mock.random_call
        lambda do
          @mock.rspec_verify
        end.should raise_error(MockExpectationError)
      end
      
      it "once should fail when not called" do
        @mock.should_receive(:random_call).once
        lambda do
          @mock.rspec_verify
        end.should raise_error(MockExpectationError)
      end

      it "once should pass when called once" do
        @mock.should_receive(:random_call).once
        @mock.random_call
        @mock.rspec_verify
      end

      it "once should pass when called once with specified args" do
        @mock.should_receive(:random_call).once.with("a", "b", "c")
        @mock.random_call("a", "b", "c")
        @mock.rspec_verify
      end

      it "once should pass when called once with unspecified args" do
        @mock.should_receive(:random_call).once
        @mock.random_call("a", "b", "c")
        @mock.rspec_verify
      end
    end
  end
end
