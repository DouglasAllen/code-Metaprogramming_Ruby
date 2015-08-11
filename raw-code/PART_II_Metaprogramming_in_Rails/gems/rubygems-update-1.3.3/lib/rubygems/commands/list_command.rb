#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'rubygems/command'
require 'rubygems/commands/query_command'

##
# An alternate to Gem::Commands::QueryCommand that searches for gems starting
# with the the supplied argument.

class Gem::Commands::ListCommand < Gem::Commands::QueryCommand

  def initialize
    super 'list', 'Display gems whose name starts with STRING'

    remove_option('--name-matches')
  end

  def arguments # :nodoc:
    "STRING        start of gem name to look for"
  end

  def defaults_str # :nodoc:
    "--local --no-details"
  end

  def usage # :nodoc:
    "#{program_name} [STRING]"
  end

  def execute
    string = get_one_optional_argument || ''
    options[:name] = /^#{string}/i
    super
  end

end

