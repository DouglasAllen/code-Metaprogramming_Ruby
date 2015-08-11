#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper'

module Spec
  module Mocks
    describe "a mock" do
      before(:each) do
        @mock = mock("mock", :null_object => true)
      end
      it "should answer false for received_message? when no messages received" do
        @mock.received_message?(:message).should be_false
      end
      it "should answer true for received_message? when message received" do
        @mock.message
        @mock.received_message?(:message).should be_true
      end
      it "should answer true for received_message? when message received with correct args" do
        @mock.message 1,2,3
        @mock.received_message?(:message, 1,2,3).should be_true
      end
      it "should answer false for received_message? when message received with incorrect args" do
        @mock.message 1,2,3
        @mock.received_message?(:message, 1,2).should be_false
      end
    end
  end
end
