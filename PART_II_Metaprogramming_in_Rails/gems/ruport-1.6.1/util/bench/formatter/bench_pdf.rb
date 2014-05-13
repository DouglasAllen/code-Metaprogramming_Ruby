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

source = Ruport::Data::Table.load("util/bench/samples/tattle.csv")

N = 1
bench_suite do  
 bench_case("Basic PDF table output", N) {
   source.to_pdf
 }
end