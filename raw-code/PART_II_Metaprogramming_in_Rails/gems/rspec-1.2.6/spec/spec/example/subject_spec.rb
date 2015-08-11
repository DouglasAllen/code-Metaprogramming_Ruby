#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper'

module Spec
  module Example
    describe "implicit subject" do
      describe "with a class" do
        it "returns an instance of the class" do
          group = Class.new(ExampleGroupDouble).describe(Array)
          example = group.new(ExampleProxy.new)
          example.subject.should == []
        end
      end
      
      describe "with a Module" do
        it "returns the Module" do
          group = Class.new(ExampleGroupDouble).describe(Enumerable)
          example = group.new(ExampleProxy.new)
          example.subject.should == Enumerable
        end
      end
      
      describe "with a string" do
        it "return the string" do
          group = Class.new(ExampleGroupDouble).describe('foo')
          example = group.new(ExampleProxy.new)
          example.subject.should == 'foo'
        end
      end

      describe "with a number" do
        it "returns the number" do
          group = Class.new(ExampleGroupDouble).describe(15)
          example = group.new(ExampleProxy.new)
          example.subject.should == 15
        end
      end
      
    end
    
    describe "explicit subject" do
      describe "defined in a top level group" do
        it "replaces the implicit subject in that group" do
          group = Class.new(ExampleGroupDouble).describe(Array)
          group.subject { [1,2,3] }
          example = group.new(ExampleProxy.new)
          example.subject.should == [1,2,3]
        end
      end

      describe "defined in a top level group" do
        before(:each) do
          @group = Class.new do
            extend  Spec::Example::Subject::ExampleGroupMethods
            include Spec::Example::Subject::ExampleMethods
            class << self
              def described_class
                Array
              end
            end
            def described_class
              self.class.described_class
            end
            
            subject {
              [1,2,3]
            }
          end
        end

        it "is available in a nested group (subclass)" do
          nested_group = Class.new(@group)
          
          example = nested_group.new
          example.subject.should == [1,2,3]
        end

        it "is available in a doubly nested group (subclass)" do
          nested_group = Class.new(@group)
          doubly_nested_group = Class.new(nested_group)

          example = doubly_nested_group.new
          example.subject.should == [1,2,3]
        end
      end
    end
  end
end
