#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + "/autotest_helper"

describe "failed_results_re" do
  it "should match a failure" do
    re = Autotest::Rspec.new.failed_results_re
    re =~ "1)\n'this example' FAILED\nreason\n/path.rb:37:\n\n"
    $1.should == "this example"
    $2.should == "reason\n/path.rb:37:"
  end

  it "should match an Error" do
    re = Autotest::Rspec.new.failed_results_re
    re =~ "1)\nRuntimeError in 'this example'\nreason\n/path.rb:37:\n\n"
    $1.should == "this example"
    $2.should == "reason\n/path.rb:37:"
  end

  it "should match an Error that doesn't end in Error" do
    re = Autotest::Rspec.new.failed_results_re
    re =~ "1)\nInvalidArgument in 'this example'\nreason\n/path.rb:37:\n\n"
    $1.should == "this example"
    $2.should == "reason\n/path.rb:37:"
  end
end