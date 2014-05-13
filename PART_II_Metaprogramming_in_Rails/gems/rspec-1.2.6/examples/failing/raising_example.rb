#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
describe "This example" do
  
  it "should show that a NoMethodError is raised but an Exception was expected" do
    proc { ''.nonexistent_method }.should raise_error
  end
  
  it "should pass" do
    proc { ''.nonexistent_method }.should raise_error(NoMethodError)
  end
  
  it "should show that a NoMethodError is raised but a SyntaxError was expected" do
    proc { ''.nonexistent_method }.should raise_error(SyntaxError)
  end
  
  it "should show that nothing is raised when SyntaxError was expected" do
    proc { }.should raise_error(SyntaxError)
  end

  it "should show that a NoMethodError is raised but a Exception was expected" do
    proc { ''.nonexistent_method }.should_not raise_error
  end
  
  it "should show that a NoMethodError is raised" do
    proc { ''.nonexistent_method }.should_not raise_error(NoMethodError)
  end
  
  it "should also pass" do
    proc { ''.nonexistent_method }.should_not raise_error(SyntaxError)
  end
  
  it "should show that a NoMethodError is raised when nothing expected" do
    proc { ''.nonexistent_method }.should_not raise_error(Exception)
  end
  
  it "should show that the wrong message was received" do
    proc { raise StandardError.new("what is an enterprise?") }.should raise_error(StandardError, "not this")
  end
  
  it "should show that the unexpected error/message was thrown" do
    proc { raise StandardError.new("abc") }.should_not raise_error(StandardError, "abc")
  end
  
  it "should pass too" do
    proc { raise StandardError.new("abc") }.should_not raise_error(StandardError, "xyz")
  end
  
end
