#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper.rb'

class LiarLiarPantsOnFire
  def respond_to?(sym, incl_private=false)
    true
  end
  
  def self.respond_to?(sym, incl_private=false)
    true
  end
end
  
describe 'should_receive' do
  before(:each) do
    @liar = LiarLiarPantsOnFire.new
  end
  
  it "should work when object lies about responding to a method" do
    @liar.should_receive(:something)
    @liar.something
  end

  it 'should work when class lies about responding to a method' do
    LiarLiarPantsOnFire.should_receive(:something)
    LiarLiarPantsOnFire.something
  end
  
  it 'should cleanup after itself' do
    (class << LiarLiarPantsOnFire; self; end).instance_methods.should_not include("something")
  end
end

