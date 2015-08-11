#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'test/unit/testcase'

module Test
  module Unit
    # This extension of the standard Test::Unit::TestCase makes RSpec
    # available from within, so that you can do things like:
    #
    # require 'spec/test/unit'
    #
    # class MyTest < Test::Unit::TestCase
    #   it "should work with Test::Unit assertions" do
    #     assert_equal 4, 2+1
    #   end
    #
    #   def test_should_work_with_rspec_expectations
    #     (3+1).should == 5
    #   end
    # end
    #
    # See also Spec::Example::ExampleGroup
    class TestCase
      extend Spec::Example::ExampleGroupMethods
      include Spec::Example::ExampleMethods

      def self.suite
        Test::Unit::TestSuiteAdapter.new(self)
      end

      def self.example_method?(method_name)
        should_method?(method_name) || test_method?(method_name)
      end

      def self.test_method?(method_name)
        method_name =~ /^test[_A-Z]./ && (
          instance_method(method_name).arity == 0 ||
          instance_method(method_name).arity == -1
        )
      end

      before(:each) {setup}
      after(:each) {teardown}

      def initialize(description, &implementation)
        super
        # Some Test::Unit extensions depend on @method_name being present.
        @method_name = description.description
        @_result = ::Test::Unit::TestResult.new
      end

      def run(ignore_this_argument=nil)
        super()
      end

    end
  end
end
