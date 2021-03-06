#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'helper'

describe 'Formatting Table' do
  it 'knows about colorized fitting' do
    t = Pry::Helpers::Table.new %w(hihi), :column_count => 1
    t.fits_on_line?(4).should == true
    t.items = []
    t.fits_on_line?(4).should == true

    t.items = %w(hi hi)
    t.fits_on_line?(4).should == true
    t.column_count = 2
    t.fits_on_line?(4).should == false

    t.items = %w(
      a   ccc
      bb  dddd
    ).sort
    t.fits_on_line?(8).should == true
    t.fits_on_line?(7).should == false
  end

  describe 'formatting - should order downward and wrap to columns' do
    FAKE_COLUMNS = 62
    def try_round_trip(expected)
      things = expected.split(/\s+/).sort
      actual = Pry::Helpers.tablify(things, FAKE_COLUMNS).to_s.strip
      [expected, actual].each{|e| e.gsub! /\s+$/, ''}
      if actual != expected
        bar = '-'*25
        puts \
          bar+'expected'+bar,
          expected,
          bar+'actual'+bar,
          actual
      end
      actual.should == expected
    end

    it 'should handle a tiny case' do
      try_round_trip(<<-eot)
asdf  asfddd  fdass
      eot
    end

    it 'should handle the basic case' do
      try_round_trip(<<-eot)
aadd            ddasffssdad  sdsaadaasd      ssfasaafssd
adassdfffaasds  f            sdsfasddasfds   ssssdaa
assfsafsfsds    fsasa        ssdsssafsdasdf
      eot
    end

    it 'should handle... another basic case' do
      try_round_trip(<<-EOT)
aaad            dasaasffaasf    fdasfdfss       safdfdddsasd
aaadfasassdfff  ddadadassasdf   fddsasadfssdss  sasf
aaddaafaf       dddasaaaaaa     fdsasad         sddsa
aas             dfsddffdddsdfd  ff              sddsfsaa
adasadfaaffds   dsfafdsfdfssda  ffadsfafsaafa   ss
asddaadaaadfdd  dssdss          ffssfsfafaadss  ssas
asdsdaa         faadf           fsddfff         ssdfssff
asfadsssaaad    fasfaafdssd     s
      EOT
    end

    it 'should handle colors' do
      try_round_trip(<<-EOT)
\e[31maaaaaaaaaa\e[0m                      \e[31mccccccccccccccccccccccccccccc\e[0m
\e[31mbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\e[0m  \e[31mddddddddddddd\e[0m
      EOT
    end

    it 'should handle empty input' do
      try_round_trip('')
    end

    it 'should handle one-token input' do
      try_round_trip('asdf')
    end
  end

  describe 'line length is smaller than the length of the longest word' do
    before do
      element = 'swizzle'
      @elem_len = element.length
      @out = [element, 'crime', 'fun']
    end

    it 'should not raise error' do
      should.not.raise(FloatDomainError) {
        Pry::Helpers.tablify(@out, @elem_len - 1)
      }
    end

    it 'should format output as one column' do
      table = Pry::Helpers.tablify(@out, @elem_len - 1).to_s
      table.should == "swizzle\ncrime  \nfun    "
    end
  end

  describe 'decide between one-line or indented output' do
    Pry::Helpers.tablify_or_one_line('head', %w(ing)).should == 'head:  ing'
  end
end
