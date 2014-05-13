#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/stack'

class StackExamples < Spec::ExampleGroup
  describe(Stack)
  before(:each) do
    @stack = Stack.new
  end
end

class EmptyStackExamples < StackExamples
  describe("when empty")
  it "should be empty" do
    @stack.should be_empty
  end
end

class AlmostFullStackExamples < StackExamples
  describe("when almost full")
  before(:each) do
    (1..9).each {|n| @stack.push n}
  end
  it "should be full" do
    @stack.should_not be_full
  end
end

class FullStackExamples < StackExamples
  describe("when full")
  before(:each) do
    (1..10).each {|n| @stack.push n}
  end
  it "should be full" do
    @stack.should be_full
  end
end