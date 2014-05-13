#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class <%= class_name %> < ActiveRecord::Migration
  def self.up
    create_table :<%= session_table_name %> do |t|
      t.string :session_id, :null => false
      t.text :data
      t.timestamps
    end

    add_index :<%= session_table_name %>, :session_id
    add_index :<%= session_table_name %>, :updated_at
  end

  def self.down
    drop_table :<%= session_table_name %>
  end
end
