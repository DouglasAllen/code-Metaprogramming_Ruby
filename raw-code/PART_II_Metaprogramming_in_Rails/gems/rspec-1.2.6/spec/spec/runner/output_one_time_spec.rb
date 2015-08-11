#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper.rb'

module Spec
  module Runner
    describe CommandLine do
      it "should not output twice" do
        dir = File.dirname(__FILE__)
        Dir.chdir("#{dir}/../../..") do
          output =`ruby #{dir}/output_one_time_fixture_runner.rb`
          output.should include("1 example, 0 failures")
          output.should_not include("0 examples, 0 failures")
        end
      end
    end
  end
end