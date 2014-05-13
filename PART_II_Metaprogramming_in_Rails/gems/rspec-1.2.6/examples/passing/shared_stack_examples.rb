#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
shared_examples_for "non-empty Stack" do

  it { @stack.should_not be_empty }
  
  it "should return the top item when sent #peek" do
    @stack.peek.should == @last_item_added
  end
  
  it "should NOT remove the top item when sent #peek" do
    @stack.peek.should == @last_item_added
    @stack.peek.should == @last_item_added
  end
  
  it "should return the top item when sent #pop" do
    @stack.pop.should == @last_item_added
  end
  
  it "should remove the top item when sent #pop" do
    @stack.pop.should == @last_item_added
    unless @stack.empty?
      @stack.pop.should_not == @last_item_added
    end
  end
  
end

shared_examples_for "non-full Stack" do

  it { @stack.should_not be_full }

  it "should add to the top when sent #push" do
    @stack.push "newly added top item"
    @stack.peek.should == "newly added top item"
  end

end