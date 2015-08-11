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
  module Mocks
    module ArgumentMatchers
      describe HashNotIncludingMatcher do
        
        it "should describe itself properly" do
          HashNotIncludingMatcher.new(:a => 5).description.should == "hash_not_including(:a=>5)"
        end      

        describe "passing" do
          it "should match a hash without the specified key" do
            hash_not_including(:c).should == {:a => 1, :b => 2}
          end
          
          it "should match a hash with the specified key, but different value" do
            hash_not_including(:b => 3).should == {:a => 1, :b => 2}
          end
                    
          it "should match a hash without the specified key, given as anything()" do
            hash_not_including(:c => anything).should == {:a => 1, :b => 2}
          end

          it "should match an empty hash" do
            hash_not_including(:a).should == {}
          end
          
          it "should match a hash without any of the specified keys" do
            hash_not_including(:a, :b, :c).should == { :d => 7}
          end
          
        end
        
        describe "failing" do
          it "should not match a non-hash" do
            hash_not_including(:a => 1).should_not == 1
          end
          
          it "should not match a hash with a specified key" do
            hash_not_including(:b).should_not == {:b => 2}
          end
          
          it "should not match a hash with the specified key/value pair" do
            hash_not_including(:b => 2).should_not == {:a => 1, :b => 2}
          end
          
          it "should not match a hash with the specified key" do
            hash_not_including(:a, :b => 3).should_not == {:a => 1, :b => 2}
          end
          
          it "should not match a hash with one of the specified keys" do
            hash_not_including(:a, :b).should_not == {:b => 2}
          end
          
          it "should not match a hash with some of the specified keys" do
            hash_not_including(:a, :b, :c).should_not == {:a => 1, :b => 2}
          end
          
          it "should not match a hash with one key/value pair included" do
            hash_not_including(:a, :b, :c, :d => 7).should_not == { :d => 7}
          end
        end
      end
    end
  end
end
