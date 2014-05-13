#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/../../../spec_helper.rb'
require 'spec/runner/formatter/snippet_extractor'

module Spec
  module Runner
    module Formatter
      describe SnippetExtractor do
        it "should fall back on a default message when it doesn't understand a line" do
          SnippetExtractor.new.snippet_for("blech").should == ["# Couldn't get snippet for blech", 1]
        end

        it "should fall back on a default message when it doesn't find the file" do
          SnippetExtractor.new.lines_around("blech", 8).should == "# Couldn't get snippet for blech"
        end
      end
    end
  end
end