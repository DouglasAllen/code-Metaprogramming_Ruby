#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
describe "when passing a block to a matcher" do
  it "you should use {} instead of do/end" do
    Object.new.should satisfy do
      "this block is being passed to #should instead of #satisfy - use {} instead"
    end
  end
end
