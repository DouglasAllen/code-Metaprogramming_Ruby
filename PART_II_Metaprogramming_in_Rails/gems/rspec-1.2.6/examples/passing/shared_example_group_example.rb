#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/spec_helper'

module SharedExampleGroupExample
  class OneThing
    def what_things_do
      "stuff"
    end
  end
  
  class AnotherThing
    def what_things_do
      "stuff"
    end
  end
  
  class YetAnotherThing
    def what_things_do
      "stuff"
    end
  end
  
  # A SharedExampleGroup is an example group that doesn't get run.
  # You can create one like this:
  share_examples_for "most things" do
    def helper_method
      "helper method"
    end
    
    it "should do what things do" do
      @thing.what_things_do.should == "stuff"
    end
  end

  # A SharedExampleGroup is also a module. If you create one like this it gets
  # assigned to the constant MostThings
  share_as :MostThings do
    def helper_method
      "helper method"
    end
    
    it "should do what things do" do
      @thing.what_things_do.should == "stuff"
    end
  end
  
  describe OneThing do
    # Now you can include the shared example group like this, which 
    # feels more like what you might say ...
    it_should_behave_like "most things"
    
    before(:each) { @thing = OneThing.new }
    
    it "should have access to helper methods defined in the shared example group" do
      helper_method.should == "helper method"
    end
  end

  describe AnotherThing do
    # ... or you can include the example group like this, which
    # feels more like the programming language we love.
    it_should_behave_like MostThings
    
    before(:each) { @thing = AnotherThing.new }

    it "should have access to helper methods defined in the shared example group" do
      helper_method.should == "helper method"
    end
  end

  describe YetAnotherThing do
    # ... or you can include the example group like this, which
    # feels more like the programming language we love.
    include MostThings
    
    before(:each) { @thing = AnotherThing.new }

    it "should have access to helper methods defined in the shared example group" do
      helper_method.should == "helper method"
    end
  end
end
