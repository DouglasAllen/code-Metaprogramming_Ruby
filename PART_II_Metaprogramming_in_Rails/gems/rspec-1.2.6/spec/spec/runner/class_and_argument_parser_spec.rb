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
  module Runner
    describe ClassAndArgumentsParser, ".parse" do
      
      it "should use a single : to separate class names from arguments" do
        ClassAndArgumentsParser.parse('Foo').should == ['Foo', nil]
        ClassAndArgumentsParser.parse('Foo:arg').should == ['Foo', 'arg']
        ClassAndArgumentsParser.parse('Foo::Bar::Zap:arg').should == ['Foo::Bar::Zap', 'arg']
        ClassAndArgumentsParser.parse('Foo:arg1,arg2').should == ['Foo', 'arg1,arg2']
        ClassAndArgumentsParser.parse('Foo::Bar::Zap:arg1,arg2').should == ['Foo::Bar::Zap', 'arg1,arg2']
        ClassAndArgumentsParser.parse('Foo::Bar::Zap:drb://foo,drb://bar').should == ['Foo::Bar::Zap', 'drb://foo,drb://bar']
      end

      it "should raise an error when passed an empty string" do
        lambda do
          ClassAndArgumentsParser.parse('')
        end.should raise_error("Couldn't parse \"\"")
      end      
    end
  end
end
