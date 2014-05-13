#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveRecord
  module Associations
    class JoinDependency # :nodoc:
      class JoinBase < JoinPart # :nodoc:
        def ==(other)
          other.class == self.class &&
            other.base_klass == base_klass
        end

        def aliased_prefix
          "t0"
        end

        def table
          Arel::Table.new(table_name, arel_engine)
        end

        def aliased_table_name
          base_klass.table_name
        end
      end
    end
  end
end
