#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# encoding: utf-8

module ActionDispatch
  module Journey # :nodoc:
    module NFA # :nodoc:
      module Dot # :nodoc:
        def to_dot
          edges = transitions.map { |from, sym, to|
            "  #{from} -> #{to} [label=\"#{sym || 'ε'}\"];"
          }

          #memo_nodes = memos.values.flatten.map { |n|
          #  label = n
          #  if Journey::Route === n
          #    label = "#{n.verb.source} #{n.path.spec}"
          #  end
          #  "  #{n.object_id} [label=\"#{label}\", shape=box];"
          #}
          #memo_edges = memos.map { |k, memos|
          #  (memos || []).map { |v| "  #{k} -> #{v.object_id};" }
          #}.flatten.uniq

        <<-eodot
digraph nfa {
  rankdir=LR;
  node [shape = doublecircle];
  #{accepting_states.join ' '};
  node [shape = circle];
#{edges.join "\n"}
}
        eodot
        end
      end
    end
  end
end
