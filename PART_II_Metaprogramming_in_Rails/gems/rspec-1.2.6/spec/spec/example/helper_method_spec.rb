#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper'

# This was added to prove that http://rspec.lighthouseapp.com/projects/5645/tickets/211
# was fixed in ruby 1.9.1

module HelperMethodExample
  describe "a helper method" do
    def helper_method
      "received call"
    end
  
    it "is available to examples in the same group" do
      helper_method.should == "received call"
    end
    
    describe "from a nested group" do
      it "is available to examples in a nested group" do
        helper_method.should == "received call"
      end
    end
    
  end
end

