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
    describe ArgumentExpectation do
      it "should consider an object that responds to #matches? and #description to be a matcher" do
        argument_expecatation = Spec::Mocks::ArgumentExpectation.new([])
        obj = mock("matcher")
        obj.should_receive(:respond_to?).with(:matches?).and_return(true)
        obj.should_receive(:respond_to?).with(:description).and_return(true)
        argument_expecatation.is_matcher?(obj).should be_true
      end

      it "should NOT consider an object that only responds to #matches? to be a matcher" do
        argument_expecatation = Spec::Mocks::ArgumentExpectation.new([])
        obj = mock("matcher")
        obj.should_receive(:respond_to?).with(:matches?).and_return(true)
        obj.should_receive(:respond_to?).with(:description).and_return(false)
        argument_expecatation.is_matcher?(obj).should be_false
      end
    end
  end
end
