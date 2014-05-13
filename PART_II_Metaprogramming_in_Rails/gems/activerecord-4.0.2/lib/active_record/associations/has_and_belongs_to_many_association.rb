#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveRecord
  # = Active Record Has And Belongs To Many Association
  module Associations
    class HasAndBelongsToManyAssociation < CollectionAssociation #:nodoc:
      attr_reader :join_table

      def initialize(owner, reflection)
        @join_table = Arel::Table.new(reflection.join_table)
        super
      end

      def insert_record(record, validate = true, raise = false)
        if record.new_record?
          if raise
            record.save!(:validate => validate)
          else
            return unless record.save(:validate => validate)
          end
        end

        if options[:insert_sql]
          owner.connection.insert(interpolate(options[:insert_sql], record))
        else
          stmt = join_table.compile_insert(
            join_table[reflection.foreign_key]             => owner.id,
            join_table[reflection.association_foreign_key] => record.id
          )

          owner.class.connection.insert stmt
        end

        record
      end

      private

        def count_records
          load_target.size
        end

        def delete_records(records, method)
          if sql = options[:delete_sql]
            records = load_target if records == :all
            records.each { |record| owner.class.connection.delete(interpolate(sql, record)) }
          else
            relation  = join_table
            condition = relation[reflection.foreign_key].eq(owner.id)

            unless records == :all
              condition = condition.and(
                relation[reflection.association_foreign_key]
                  .in(records.map { |x| x.id }.compact)
              )
            end

            owner.class.connection.delete(relation.where(condition).compile_delete)
          end
        end

        def invertible_for?(record)
          false
        end
    end
  end
end
