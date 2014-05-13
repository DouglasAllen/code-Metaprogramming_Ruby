#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + "/autotest_helper"

describe Autotest::Rspec, "discovery" do
  it "adds the rspec autotest plugin" do
    Autotest.should_receive(:add_discovery)
    require File.dirname(__FILE__) + "/../../lib/autotest/discover"
  end
end  
