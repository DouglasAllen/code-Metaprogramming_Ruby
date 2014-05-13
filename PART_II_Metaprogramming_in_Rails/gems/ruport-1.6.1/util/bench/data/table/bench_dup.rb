#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require "ruport"
require "enumerator"
require "rubygems"
require "ruport/util/bench"
include Ruport::Bench

deep_data = (0..299).enum_slice(3).to_a

col_names = (0..99).map { |r| r.to_s }
wide_data = (0..299).enum_slice(100).to_a

small_table = Table(%w[a b c]) << [1,2,3] << [4,5,6]
deep_table = deep_data.to_table(%w[a b c]) 
wide_table = wide_data.to_table(col_names)

SMALL_N = 1000
DEEP_N  = 100
WIDE_N  = 100

bench_suite do  
 bench_case("Table#dup - small table", SMALL_N) { small_table.dup }
 bench_case("Table#dup - deep table", DEEP_N) { deep_table.dup }
 bench_case("Table#dup - wide table", WIDE_N) { wide_table.dup }  
end
