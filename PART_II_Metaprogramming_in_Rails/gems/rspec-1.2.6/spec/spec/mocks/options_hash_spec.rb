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
    describe "calling :should_receive with an options hash" do
      it "should report the file and line submitted with :expected_from" do
        begin
          mock = Spec::Mocks::Mock.new("a mock")
          mock.should_receive(:message, :expected_from => "/path/to/blah.ext:37")
          mock.rspec_verify
        rescue => e
        ensure
          e.backtrace.to_s.should =~ /\/path\/to\/blah.ext:37/m
        end
      end

      it "should use the message supplied with :message" do
        lambda {
          m = Spec::Mocks::Mock.new("a mock")
          m.should_receive(:message, :message => "recebi nada")
          m.rspec_verify
        }.should raise_error("recebi nada")
      end
      
      it "should use the message supplied with :message after a similar stub" do
        lambda {
          m = Spec::Mocks::Mock.new("a mock")
          m.stub!(:message)
          m.should_receive(:message, :message => "from mock")
          m.rspec_verify
        }.should raise_error("from mock")
      end
    end
  end
end
