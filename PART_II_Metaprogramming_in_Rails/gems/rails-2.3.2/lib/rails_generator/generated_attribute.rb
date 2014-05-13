#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'optparse'

module Rails
  module Generator
    class GeneratedAttribute
      attr_accessor :name, :type, :column

      def initialize(name, type)
        @name, @type = name, type.to_sym
        @column = ActiveRecord::ConnectionAdapters::Column.new(name, nil, @type)
      end

      def field_type
        @field_type ||= case type
          when :integer, :float, :decimal   then :text_field
          when :datetime, :timestamp, :time then :datetime_select
          when :date                        then :date_select
          when :string                      then :text_field
          when :text                        then :text_area
          when :boolean                     then :check_box
          else
            :text_field
        end      
      end

      def default
        @default ||= case type
          when :integer                     then 1
          when :float                       then 1.5
          when :decimal                     then "9.99"
          when :datetime, :timestamp, :time then Time.now.to_s(:db)
          when :date                        then Date.today.to_s(:db)
          when :string                      then "MyString"
          when :text                        then "MyText"
          when :boolean                     then false
          else
            ""
        end      
      end

      def reference?
        [ :references, :belongs_to ].include?(self.type)
      end
    end
  end
end
