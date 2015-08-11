#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'spec/runner/formatter/html_formatter'

module Spec
  module Runner
    module Formatter
      # Formats backtraces so they're clickable by TextMate
      class TextMateFormatter < HtmlFormatter
        def backtrace_line(line)
          line.gsub(/([^:]*\.rb):(\d*)/) do
            "<a href=\"txmt://open?url=file://#{File.expand_path($1)}&line=#{$2}\">#{$1}:#{$2}</a> "
          end
        end
      end
    end
  end
end
