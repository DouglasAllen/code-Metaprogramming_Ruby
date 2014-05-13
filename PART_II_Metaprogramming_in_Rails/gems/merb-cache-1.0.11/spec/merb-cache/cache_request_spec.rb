#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/../spec_helper'

describe Merb::Cache::CacheRequest do
  it "should subclass Merb::Request" do
    Merb::Cache::CacheRequest.superclass.should == Merb::Request
  end

  describe "#path" do
    it "can be specified without manipulating the env" do
      Merb::Cache::CacheRequest.new('/path/to/foo').path.should == '/path/to/foo'
    end
  end

  describe "#params" do
    it "can be specified without manipulating the env" do
      Merb::Cache::CacheRequest.new('/', 'foo' => 'bar').params.should == {'foo' => 'bar'}
    end
  end

  describe "#env" do
    it "can be specified in the constructor" do
      Merb::Cache::CacheRequest.new('', {}, 'foo' => 'bar').env['foo'].should == 'bar'
    end
  end

  it "should setup a default env" do
    Merb::Cache::CacheRequest.new('').env.should_not be_empty
  end
end