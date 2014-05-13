#!/usr/bin/env ruby
#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---

module Rake

  # Makefile loader to be used with the import file loader.
  class MakefileLoader
    SPACE_MARK = "__&NBSP;__"

    # Load the makefile dependencies in +fn+.
    def load(fn)
      open(fn) do |mf|
        lines = mf.read
        lines.gsub!(/\\ /, SPACE_MARK)
        lines.gsub!(/#[^\n]*\n/m, "")
        lines.gsub!(/\\\n/, ' ')
        lines.split("\n").each do |line|
          process_line(line)
        end
      end
    end

    private

    # Process one logical line of makefile data.
    def process_line(line)
      file_tasks, args = line.split(':')
      return if args.nil?
      dependents = args.split.map { |d| respace(d) }
      file_tasks.strip.split.each do |file_task|
        file_task = respace(file_task)
        file file_task => dependents
      end
    end
    
    def respace(str)
      str.gsub(/#{SPACE_MARK}/, ' ')
    end
  end

  # Install the handler
  Rake.application.add_loader('mf', MakefileLoader.new)
end
