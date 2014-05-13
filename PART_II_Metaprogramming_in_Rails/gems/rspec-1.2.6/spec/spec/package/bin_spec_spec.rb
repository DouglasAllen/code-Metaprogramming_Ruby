#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/../../ruby_forker'

describe "The bin/spec script" do
  include RubyForker
  
  it "should have no warnings" do
    pending "Hangs on JRuby" if RUBY_PLATFORM =~ /java/
    location = "#{File.dirname(__FILE__)}/../../../bin/spec"

    output = ruby "-w #{location} --help 2>&1"
    output.should_not =~ /warning/n
  end
  
  it "should show the help w/ no args" do
    pending "Hangs on JRuby" if RUBY_PLATFORM =~ /java/
    location = "#{File.dirname(__FILE__)}/../../../bin/spec"

    output = ruby "-w #{location} 2>&1"
    output.should =~ /^Usage: spec/
  end
end
