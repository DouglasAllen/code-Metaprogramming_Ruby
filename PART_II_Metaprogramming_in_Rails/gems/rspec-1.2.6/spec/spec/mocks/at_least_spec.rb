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
    describe "at_least" do
      before(:each) do
        @mock = Mock.new("test mock")
      end

      it "should fail if method is never called" do
        @mock.should_receive(:random_call).at_least(4).times
          lambda do
        @mock.rspec_verify
        end.should raise_error(MockExpectationError)
      end

      it "should fail when called less than n times" do
        @mock.should_receive(:random_call).at_least(4).times
        @mock.random_call
        @mock.random_call
        @mock.random_call
        lambda do
          @mock.rspec_verify
        end.should raise_error(MockExpectationError)
      end

      it "should fail when at least once method is never called" do
        @mock.should_receive(:random_call).at_least(:once)
        lambda do
          @mock.rspec_verify
        end.should raise_error(MockExpectationError)
      end

      it "should fail when at least twice method is called once" do
        @mock.should_receive(:random_call).at_least(:twice)
        @mock.random_call
        lambda do
          @mock.rspec_verify
        end.should raise_error(MockExpectationError)
      end

      it "should fail when at least twice method is never called" do
        @mock.should_receive(:random_call).at_least(:twice)
        lambda do
          @mock.rspec_verify
        end.should raise_error(MockExpectationError)
      end

      it "should pass when at least n times method is called exactly n times" do
        @mock.should_receive(:random_call).at_least(4).times
        @mock.random_call
        @mock.random_call
        @mock.random_call
        @mock.random_call
        @mock.rspec_verify
      end

      it "should pass when at least n times method is called n plus 1 times" do
        @mock.should_receive(:random_call).at_least(4).times
        @mock.random_call
        @mock.random_call
        @mock.random_call
        @mock.random_call
        @mock.random_call
        @mock.rspec_verify
      end

      it "should pass when at least once method is called once" do
        @mock.should_receive(:random_call).at_least(:once)
        @mock.random_call
        @mock.rspec_verify
      end

      it "should pass when at least once method is called twice" do
        @mock.should_receive(:random_call).at_least(:once)
        @mock.random_call
        @mock.random_call
        @mock.rspec_verify
      end

      it "should pass when at least twice method is called three times" do
        @mock.should_receive(:random_call).at_least(:twice)
        @mock.random_call
        @mock.random_call
        @mock.random_call
        @mock.rspec_verify
      end

      it "should pass when at least twice method is called twice" do
        @mock.should_receive(:random_call).at_least(:twice)
        @mock.random_call
        @mock.random_call
        @mock.rspec_verify
      end
    end
  end
end
