#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/spec_helper'

# Run "spec implicit_docstrings_example.rb --format specdoc" to see the output of this file

describe "Examples with no docstrings generate their own:" do

  specify { 3.should be < 5 }

  specify { ["a"].should include("a") }

  specify { [1,2,3].should respond_to(:size) }

end

describe 1 do
  it { should == 1 }
  it { should be < 2}
end
