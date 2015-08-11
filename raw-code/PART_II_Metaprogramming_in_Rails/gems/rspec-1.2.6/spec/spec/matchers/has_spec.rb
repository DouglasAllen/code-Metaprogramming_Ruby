#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper.rb'

describe "should have_sym(*args)" do
  it "should pass if #has_sym?(*args) returns true" do
    {:a => "A"}.should have_key(:a)
  end

  it "should fail if #has_sym?(*args) returns false" do
    lambda {
      {:b => "B"}.should have_key(:a)
    }.should fail_with("expected #has_key?(:a) to return true, got false")
  end

  it "should fail if target does not respond to #has_sym?" do
    lambda {
      Object.new.should have_key(:a)
    }.should raise_error(NoMethodError)
  end
  
  it "should reraise an exception thrown in #has_sym?(*args)" do
    o = Object.new
    def o.has_sym?(*args)
      raise "Funky exception"
    end
    lambda { o.should have_sym(:foo) }.should raise_error("Funky exception")
  end
end

describe "should_not have_sym(*args)" do
  it "should pass if #has_sym?(*args) returns false" do
    {:a => "A"}.should_not have_key(:b)
  end

  it "should fail if #has_sym?(*args) returns true" do
    lambda {
      {:a => "A"}.should_not have_key(:a)
    }.should fail_with("expected #has_key?(:a) to return false, got true")
  end

  it "should fail if target does not respond to #has_sym?" do
    lambda {
      Object.new.should have_key(:a)
    }.should raise_error(NoMethodError)
  end
  
  it "should reraise an exception thrown in #has_sym?(*args)" do
    o = Object.new
    def o.has_sym?(*args)
      raise "Funky exception"
    end
    lambda { o.should_not have_sym(:foo) }.should raise_error("Funky exception")
  end
end

describe "has" do
  it "should work when the target implements #send" do
    o = {:a => "A"}
    def o.send(*args); raise "DOH! Library developers shouldn't use #send!" end
    lambda {
      o.should have_key(:a)
    }.should_not raise_error
  end
end
