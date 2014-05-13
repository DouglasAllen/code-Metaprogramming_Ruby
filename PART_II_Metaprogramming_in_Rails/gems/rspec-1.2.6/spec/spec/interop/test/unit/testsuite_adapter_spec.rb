#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/test_unit_spec_helper'

describe "TestSuiteAdapter" do
  include TestUnitSpecHelper
  it "should pass" do
    dir = File.dirname(__FILE__)
    run_script "#{dir}/resources/testsuite_adapter_spec_with_test_unit.rb"
  end
end