#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---

require "benchmark"
require "rubygems" 
require "ruport"  
require "ruport/util/bench"
include Ruport::Bench

class MyFormat < Ruport::Formatter;
  renders :nothing, :for => Ruport::Controller::Row
end

record = Ruport::Data::Record.new [1,2,3]

bench_suite do
  N = 10000   
  bench_case("as(:nothing)",N) { record.as(:nothing) }
  bench_case("to_nothing",N) { record.to_nothing }
end
