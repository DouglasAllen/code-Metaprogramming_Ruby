#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class <%= class_name.underscore.camelize %> < ActiveRecord::Migration
  def self.up<% attributes.each do |attribute| %>
    <%= migration_action %>_column :<%= table_name %>, :<%= attribute.name %><% if migration_action == 'add' %>, :<%= attribute.type %><% end -%>
  <%- end %>
  end

  def self.down<% attributes.reverse.each do |attribute| %>
    <%= migration_action == 'add' ? 'remove' : 'add' %>_column :<%= table_name %>, :<%= attribute.name %><% if migration_action == 'remove' %>, :<%= attribute.type %><% end -%>
  <%- end %>
  end
end
