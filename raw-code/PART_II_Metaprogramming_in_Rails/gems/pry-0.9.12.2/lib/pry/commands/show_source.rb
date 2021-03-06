#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'pry/commands/show_info'

class Pry
  class Command::ShowSource < Command::ShowInfo
    match 'show-source'
    group 'Introspection'
    description 'Show the source for a method or class.'

    banner <<-'BANNER'
      Usage:   show-source [OPTIONS] [METH|CLASS]
      Aliases: $, show-method

      Show the source for a method or class. Tries instance methods first and then
      methods by default.

      show-source hi_method
      show-source hi_method
      show-source Pry#rep     # source for Pry#rep method
      show-source Pry         # for Pry class
      show-source Pry -a      # for all Pry class definitions (all monkey patches)
      show-source Pry --super # for superclass of Pry (Object class)

      https://github.com/pry/pry/wiki/Source-browsing#wiki-Show_method
    BANNER

    # The source for code_object prepared for display.
    def content_for(code_object)
      cannot_locate_source_error if !code_object.source

      Code.new(code_object.source, start_line_for(code_object)).
        with_line_numbers(use_line_numbers?).to_s
    end
  end

  Pry::Commands.add_command(Pry::Command::ShowSource)
  Pry::Commands.alias_command 'show-method', 'show-source'
  Pry::Commands.alias_command '$', 'show-source'
end
