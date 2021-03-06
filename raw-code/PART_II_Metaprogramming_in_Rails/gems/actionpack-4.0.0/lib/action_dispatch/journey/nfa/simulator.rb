#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'strscan'

module ActionDispatch
  module Journey # :nodoc:
    module NFA # :nodoc:
      class MatchData # :nodoc:
        attr_reader :memos

        def initialize(memos)
          @memos = memos
        end
      end

      class Simulator # :nodoc:
        attr_reader :tt

        def initialize(transition_table)
          @tt = transition_table
        end

        def simulate(string)
          input = StringScanner.new(string)
          state = tt.eclosure(0)
          until input.eos?
            sym   = input.scan(%r([/.?]|[^/.?]+))

            # FIXME: tt.eclosure is not needed for the GTG
            state = tt.eclosure(tt.move(state, sym))
          end

          acceptance_states = state.find_all { |s|
            tt.accepting?(tt.eclosure(s).sort.last)
          }

          return if acceptance_states.empty?

          memos = acceptance_states.map { |x| tt.memo(x) }.flatten.compact

          MatchData.new(memos)
        end

        alias :=~    :simulate
        alias :match :simulate
      end
    end
  end
end
