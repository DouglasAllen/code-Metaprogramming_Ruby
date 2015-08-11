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
  module Matchers
    module DSL
      describe "#create" do
        it "is deprecated" do
          Spec.should_receive(:deprecate)
          mod = Module.new
          mod.extend Spec::Matchers::DSL
          mod.create(:foo)
        end
      end
      
      describe "#define" do
        it "creates a method that initializes a new matcher with the submitted name and expected arg" do
          # FIXME - this expects new to be called, but we need something
          # more robust - that expects new to be called with a specific
          # block (lambda, proc, whatever)
          mod = Module.new
          mod.extend Spec::Matchers::DSL
          mod.define(:foo)
    
          obj = Object.new
          obj.extend mod
    
          Spec::Matchers::Matcher.should_receive(:new).with(:foo, 3)
    
          obj.foo(3)
        end
      end
    end
  end
end
