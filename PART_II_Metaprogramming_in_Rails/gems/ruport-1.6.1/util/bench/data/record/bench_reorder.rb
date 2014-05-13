#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require "ruport"
require "rubygems"
require "ruport/util/bench"
include Ruport::Bench

large = (1..1000).to_a
large_attributes = large.map { |e| e.to_s.reverse }

rand_large_attributes = large_attributes.sort_by { rand }


large_record = Ruport::Data::Record.new large,
               :attributes => large_attributes

small_record = Ruport::Data::Record.new({ "foo"  => 'bar', 
                                           "baz"  => "bang",
                                           "Quux" => "adfdsa" })

rand_small_attributes = small_record.attributes.sort_by { rand }

SMALL_N = 10000
LARGE_N = 100

bench_suite do

  bench_case("reorder - small", SMALL_N) {
    record = small_record.dup
    record.reorder(rand_small_attributes)
  }
  bench_case("reorder - large", LARGE_N) {
    record = large_record.dup
    record.reorder(rand_large_attributes)
  }

end
