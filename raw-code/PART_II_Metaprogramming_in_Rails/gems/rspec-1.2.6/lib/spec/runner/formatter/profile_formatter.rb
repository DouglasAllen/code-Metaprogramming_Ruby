#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'spec/runner/formatter/progress_bar_formatter'

module Spec
  module Runner
    module Formatter
      class ProfileFormatter < ProgressBarFormatter
        
        def initialize(options, where)
          super
          @example_times = []
        end
        
        def start(count)
          @output.puts "Profiling enabled."
        end
        
        def example_started(example)
          @time = Time.now
        end
        
        def example_passed(example)
          super
          @example_times << [
            example_group.description,
            example.description,
            Time.now - @time
          ]
        end
        
        def start_dump
          super
          @output.puts "\n\nTop 10 slowest examples:\n"
          
          @example_times = @example_times.sort_by do |description, example, time|
            time
          end.reverse
          
          @example_times[0..9].each do |description, example, time|
            @output.print red(sprintf("%.7f", time))
            @output.puts " #{description} #{example}"
          end
          @output.flush
        end
      end
    end
  end
end
