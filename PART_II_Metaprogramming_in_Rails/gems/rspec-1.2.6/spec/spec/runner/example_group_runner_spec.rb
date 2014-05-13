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
  module Runner
    describe ExampleGroupRunner do
      before(:each) do
        err = StringIO.new('')
        out = StringIO.new('')
        @options = Options.new(err, out)
        @runner = Spec::Runner::ExampleGroupRunner.new(@options)
      end

      after(:each) do
        Spec::Expectations.differ = nil
      end

      describe "#load_files" do
        it "should load UTF-8 encoded files" do
          file = File.expand_path(File.dirname(__FILE__) + "/resources/utf8_encoded.rb")
          @options.files << file
          @runner.load_files(@options.files_to_load).should == @options.files_to_load
        end
      end
    end
  end
end
