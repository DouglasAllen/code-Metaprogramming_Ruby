#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
# This demonstrates the use of the options hash to support custom reporting.
# To see the result, run this command from the project root:
# 
#   bin/spec --require examples/passing/options_formatter.rb examples/passing/options_example.rb \
#     --format OptionsFormatter

require File.dirname(__FILE__) + '/spec_helper'

describe "this group will be reported", :report => true do
  it "this example will be reported", :report => true do
    # no-op
  end

  it "this example will not be reported", :report => false do
    # no-op
  end

  it "this example will also not be reported", :foo => 'bar' do
    # no-op
  end

  it "this example will also also not be reported" do
    # no-op
  end
end

describe "this group will not be reported", :report => false do
  it "though this example will", :report => true do
    # no-op
  end
end