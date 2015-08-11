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
    describe "mock failure" do
      
      it "should tell you when it receives the right message with the wrong args" do
        m = mock("foo")
        m.should_receive(:bar).with("message")
        lambda {
          m.bar("different message")
        }.should raise_error(Spec::Mocks::MockExpectationError, %Q{Mock 'foo' expected :bar with ("message") but received it with ("different message")})
        m.bar("message") # allows the spec to pass
      end

      it "should tell you when it receives the right message with the wrong args if you stub the method" do
        pending("fix bug 15719")
        # NOTE - for whatever reason, if you use a the block style of pending here,
        # rcov gets unhappy. Don't know why yet.
        m = mock("foo")
        m.stub!(:bar)
        m.should_receive(:bar).with("message")
        lambda {
          m.bar("different message")
        }.should raise_error(Spec::Mocks::MockExpectationError, %Q{Mock 'foo' expected :bar with ("message") but received it with ("different message")})
        m.bar("message") # allows the spec to pass
      end
    end
  end
end