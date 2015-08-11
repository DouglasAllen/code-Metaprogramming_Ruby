#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'rubygems'

require 'ruport'
table = Ruport::Data::Table.new :column_names => ["country", "wine"],
                                :data => [["France", "Bordeaux"],
                                          ["Italy", "Chianti"],
                                          ["France", "Chablis"]]
puts table.to_text

found = table.rows_with_country("France")
found.each do |row|
  puts row.to_csv
end
