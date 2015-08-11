#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
rspec_lib = File.dirname(__FILE__) + "/../../../../../../lib"
$:.unshift rspec_lib unless $:.include?(rspec_lib)
require 'spec/autorun'
require 'spec/test/unit'

module Test
  module Unit
    describe TestSuiteAdapter do
      def create_adapter(group)
        TestSuiteAdapter.new(group)
      end

      describe "#size" do
        it "should return the number of examples in the example group" do
          group = Class.new(Spec::ExampleGroup) do
            describe("some examples")
            it("bar") {}
            it("baz") {}
          end
          adapter = create_adapter(group)
          adapter.size.should == 2
        end
      end

      describe "#delete" do
        it "should do nothing" do
          group = Class.new(Spec::ExampleGroup) do
            describe("Some Examples")
            it("does something") {}
          end
          adapter = create_adapter(group)
          adapter.delete(adapter.examples.first)
          adapter.should be_empty
        end
      end
    end
  end
end
