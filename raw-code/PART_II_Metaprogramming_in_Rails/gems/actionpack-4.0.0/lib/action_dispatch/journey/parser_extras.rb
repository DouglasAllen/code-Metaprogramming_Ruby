#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'action_dispatch/journey/scanner'
require 'action_dispatch/journey/nodes/node'

module ActionDispatch
  module Journey # :nodoc:
    class Parser < Racc::Parser # :nodoc:
      include Journey::Nodes

      def initialize
        @scanner = Scanner.new
      end

      def parse(string)
        @scanner.scan_setup(string)
        do_parse
      end

      def next_token
        @scanner.next_token
      end
    end
  end
end
