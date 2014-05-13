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
    describe "A chained method stub" do
      before(:each) do
        @subject = Object.new
      end

      it "returns expected value from chaining only one method call" do
        @subject.stub_chain(:msg1).and_return(:return_value)
        @subject.msg1.should equal(:return_value)
      end

      it "returns expected value from chaining two method calls" do
        @subject.stub_chain(:msg1, :msg2).and_return(:return_value)
        @subject.msg1.msg2.should equal(:return_value)
      end

      it "returns expected value from chaining four method calls" do
        @subject.stub_chain(:msg1, :msg2, :msg3, :msg4).and_return(:return_value)
        @subject.msg1.msg2.msg3.msg4.should equal(:return_value)
      end

    end
  end
end
