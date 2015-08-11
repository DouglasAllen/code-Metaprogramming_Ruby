#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper.rb'

module Bug7611
  class Foo
  end

  class Bar < Foo
  end

  describe "A Partial Mock" do
    it "should respect subclasses" do
      Foo.stub!(:new).and_return(Object.new)
    end

    it "should" do
      Bar.new.class.should == Bar
    end 
  end
end
