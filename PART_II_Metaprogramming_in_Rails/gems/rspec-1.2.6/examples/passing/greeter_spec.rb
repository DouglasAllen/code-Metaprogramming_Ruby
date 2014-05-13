#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/spec_helper'
# greeter.rb
#
# Based on http://glu.ttono.us/articles/2006/12/19/tormenting-your-tests-with-heckle
#
# Run with:
#
#   spec greeter_spec.rb --heckle Greeter
#
class Greeter
  def initialize(person = nil)
    @person = person
  end

  def greet
    @person.nil? ? "Hi there!" : "Hi #{@person}!"
  end
end

describe "Greeter" do
  it "should say Hi to person" do
    greeter = Greeter.new("Kevin")
    greeter.greet.should == "Hi Kevin!"
  end

  it "should say Hi to nobody" do
    greeter = Greeter.new
    # Uncomment the next line to make Heckle happy
    #greeter.greet.should == "Hi there!"
  end
end
