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
    class GrandParentExampleGroup < Spec::Example::ExampleGroup
      describe "Grandparent ExampleGroup"
    end

    class ParentExampleGroup < GrandParentExampleGroup
      describe "Parent ExampleGroup"
      it "should bar" do
      end
    end

    class ChildExampleGroup < ParentExampleGroup
      describe "Child ExampleGroup"
      it "should bam" do
      end
    end

    describe ChildExampleGroup do

    end
  end
end
