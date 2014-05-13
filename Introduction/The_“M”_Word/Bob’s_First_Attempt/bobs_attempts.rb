#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
# http://media.pragprog.com/titles/ppmetr/code/introduction/orm.rb ---
# Mock database
# (it prints the SQL and returns an empty result set)
class Database
  def self.sql(sql)
    puts sql
    [[]]
  end
end

class Entity
  attr_reader :table, :ident
  
  def initialize(table, ident)
    @table = table
    @ident = ident
    Database.sql "INSERT INTO #{@table} (id) VALUES (#{@ident})"
  end
  
  def set(col, val)
    Database.sql "UPDATE #{@table} SET #{col}='#{val}' WHERE id=#{@ident}"
  end
  
  def get(col)
    Database.sql("SELECT #{col} FROM #{@table} WHERE id=#{@ident}")[0][0]
  end
end

class Movie1 < Entity
  def initialize(ident)
    super("movies", ident)
  end

  def title
    get("title")
  end
  
  def title=(value)
    set("title", value)
  end
  
  def director
    get("director")
  end
  
  def director=(value)
    set("director", value)
  end
end

movie1 = Movie1.new(1)
movie1.title = "Doctor Strangelove"
movie1.director = "Stanley Kubrick"

require 'active_record'

# Create a new database each time
File.delete 'dbfile.db' if File.exist? 'dbfile.db'

require 'active_record'
ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "dbfile.db"
                                        
# Initialize the database schema
ActiveRecord::Base.connection.create_table :movies do |t|
   t.string  :title
   t.string  :director
end

class Movie < ActiveRecord::Base
end

movie = Movie.create
p movie.valid?         # => true
movie.title = "Doctor Strangelove"
movie.director = "Stanley Kubrick"
puts Movie.all.inspect
puts "oops! Better save it"
movie.save!
puts Movie.all.inspect