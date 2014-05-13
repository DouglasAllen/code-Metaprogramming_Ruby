#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'spec/runner/formatter/base_text_formatter'

module Spec
  module Runner
    module Formatter
      class SpecdocFormatter < BaseTextFormatter
        def example_group_started(example_group)
          super
          output.puts
          output.puts example_group.description
          output.flush
        end
      
        def example_failed(example, counter, failure)
          output.puts(red("- #{example.description} (FAILED - #{counter})"))
          output.flush
        end
        
        def example_passed(example)
          message = "- #{example.description}"
          output.puts green(message)
          output.flush
        end
        
        def example_pending(example, message, deprecated_pending_location=nil)
          super
          output.puts yellow("- #{example.description} (PENDING: #{message})")
          output.flush
        end
      end
    end
  end
end
