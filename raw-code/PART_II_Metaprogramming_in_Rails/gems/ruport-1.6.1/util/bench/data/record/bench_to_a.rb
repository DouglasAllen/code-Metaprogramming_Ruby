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

large_record = Ruport::Data::Record.new(large,
                                        :attributes => large_attributes)

small_record = Ruport::Data::Record.new([1,2,3],
                                        :attributes => %w[a b c])
SMALL_N = 100000
LARGE_N = 1000
bench_suite do
  bench_case("to_a : Large Record",LARGE_N) { large_record.to_a }
  bench_case("to_a: Small Record",SMALL_N) { small_record.to_a }
end
