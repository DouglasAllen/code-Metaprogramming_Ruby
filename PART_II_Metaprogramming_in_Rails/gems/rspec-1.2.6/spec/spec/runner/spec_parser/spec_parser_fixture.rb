#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/../../../spec_helper.rb'

describe "c" do

  it "1" do
  end

  it "2" do
  end

end

describe "d" do

  it "3" do
  end

  it "4" do
  end

end

class SpecParserSubject
end

describe SpecParserSubject do

  it "5" do
  end

end

describe SpecParserSubject, "described" do

  it "6" do
  end

end

describe SpecParserSubject, "described", :something => :something_else do

   it "7" do
   end

end

describe "described", :something => :something_else do

  it "8" do
  end

end

describe "e" do

  it "9" do
  end

  it "10" do
  end

  describe "f" do
    it "11" do
    end

    it "12" do
    end
  end

end
