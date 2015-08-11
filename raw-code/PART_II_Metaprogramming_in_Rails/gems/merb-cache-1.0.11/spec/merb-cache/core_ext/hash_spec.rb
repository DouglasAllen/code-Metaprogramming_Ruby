#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper'

describe Hash do
  
  describe "to_sha1" do
    before(:each) do
      @params = {:id => 1, :string => "string", :symbol => :symbol}
    end
    
    it{@params.should respond_to(:to_sha2)}
    
    it "should encode the hash by alphabetic key" do
      string = ""
      @params.keys.sort_by{|k| k.to_s}.each{|k| string << @params[k].to_s}
      digest = Digest::SHA2.hexdigest(string)    
      @params.to_sha2.should == digest      
    end  
  end
  
end