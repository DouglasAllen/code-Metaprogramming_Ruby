#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/spec_helper'

describe "arrays" do
  def contain_same_elements_as(expected)
    simple_matcher "array with same elements in any order as #{expected.inspect}" do |actual|
      if actual.size == expected.size
        a, e = actual.dup, expected.dup
        until e.empty? do
          if i = a.index(e.pop) then a.delete_at(i) end
        end
        a.empty?
      else
        false
      end
    end
  end
  
  describe "can be matched by their contents disregarding order" do
    subject { [1,2,2,3] }
    it { should contain_same_elements_as([1,2,2,3]) }
    it { should contain_same_elements_as([2,3,2,1]) }
    it { should_not contain_same_elements_as([3,3,2,1]) }
  end
  
  describe "fail the match with different contents" do
    subject { [1,2,3] }
    it { should_not contain_same_elements_as([2,3,4])}
    it { should_not contain_same_elements_as([1,2,2,3])}
    it { should_not contain_same_elements_as([1,2])}
  end
end