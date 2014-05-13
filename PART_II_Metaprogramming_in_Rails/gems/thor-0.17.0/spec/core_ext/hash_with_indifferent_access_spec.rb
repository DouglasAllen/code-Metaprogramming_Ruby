#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'thor/core_ext/hash_with_indifferent_access'

describe Thor::CoreExt::HashWithIndifferentAccess do
  before do
    @hash = Thor::CoreExt::HashWithIndifferentAccess.new :foo => 'bar', 'baz' => 'bee', :force => true
  end

  it "has values accessible by either strings or symbols" do
    expect(@hash['foo']).to eq('bar')
    expect(@hash[:foo]).to eq('bar')

    expect(@hash.values_at(:foo, :baz)).to eq(['bar', 'bee'])
    expect(@hash.delete(:foo)).to eq('bar')
  end

  it "handles magic boolean predicates" do
    expect(@hash.force?).to be_true
    expect(@hash.foo?).to be_true
    expect(@hash.nothing?).to be_false
  end

  it "handles magic comparisions" do
    expect(@hash.foo?('bar')).to be_true
    expect(@hash.foo?('bee')).to be_false
  end

  it "maps methods to keys" do
    expect(@hash.foo).to eq(@hash['foo'])
  end

  it "merges keys independent if they are symbols or strings" do
    @hash.merge!('force' => false, :baz => "boom")
    expect(@hash[:force]).to eq(false)
    expect(@hash[:baz]).to eq("boom")
  end

  it "creates a new hash by merging keys independent if they are symbols or strings" do
    other = @hash.merge('force' => false, :baz => "boom")
    expect(other[:force]).to eq(false)
    expect(other[:baz]).to eq("boom")
  end

  it "converts to a traditional hash" do
    expect(@hash.to_hash.class).to eq(Hash)
    expect(@hash).to eq({ 'foo' => 'bar', 'baz' => 'bee', 'force' => true })
  end
end
