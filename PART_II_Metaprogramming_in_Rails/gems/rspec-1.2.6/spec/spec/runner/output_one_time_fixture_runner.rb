#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
dir = File.dirname(__FILE__)
require "#{dir}/../../spec_helper"

triggering_double_output = Spec::Runner.options
options = Spec::Runner::OptionParser.parse(
  ["#{dir}/output_one_time_fixture.rb"], $stderr, $stdout
)
Spec::Runner::CommandLine.run(options)
