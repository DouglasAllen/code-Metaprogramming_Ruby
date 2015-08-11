#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path('../../../load_paths', __FILE__)
require "active_record"
require 'benchmark/ips'

TIME    = (ENV['BENCHMARK_TIME'] || 20).to_i
RECORDS = (ENV['BENCHMARK_RECORDS'] || TIME*1000).to_i

conn = { :adapter => 'sqlite3', :database => ':memory:' }

ActiveRecord::Base.establish_connection(conn)

class User < ActiveRecord::Base
  connection.create_table :users, :force => true do |t|
    t.string :name, :email
    t.timestamps
  end

  has_many :exhibits
end

class Exhibit < ActiveRecord::Base
  connection.create_table :exhibits, :force => true do |t|
    t.belongs_to :user
    t.string :name
    t.text :notes
    t.timestamps
  end

  belongs_to :user

  def look; attributes end
  def feel; look; user.name end

  def self.with_name
    where("name IS NOT NULL")
  end

  def self.with_notes
    where("notes IS NOT NULL")
  end

  def self.look(exhibits) exhibits.each { |e| e.look } end
  def self.feel(exhibits) exhibits.each { |e| e.feel } end
end

puts 'Generating data...'

module ActiveRecord
  class Faker
    LOREM = %Q{Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse non aliquet diam. Curabitur vel urna metus, quis malesuada elit.
     Integer consequat tincidunt felis. Etiam non erat dolor. Vivamus imperdiet nibh sit amet diam eleifend id posuere diam malesuada. Mauris at accumsan sem.
     Donec id lorem neque. Fusce erat lorem, ornare eu congue vitae, malesuada quis neque. Maecenas vel urna a velit pretium fermentum. Donec tortor enim,
     tempor venenatis egestas a, tempor sed ipsum. Ut arcu justo, faucibus non imperdiet ac, interdum at diam. Pellentesque ipsum enim, venenatis ut iaculis vitae,
     varius vitae sem. Sed rutrum quam ac elit euismod bibendum. Donec ultricies ultricies magna, at lacinia libero mollis aliquam. Sed ac arcu in tortor elementum
     tincidunt vel interdum sem. Curabitur eget erat arcu. Praesent eget eros leo. Nam magna enim, sollicitudin vehicula scelerisque in, vulputate ut libero.
     Praesent varius tincidunt commodo}.split

    def self.name
      LOREM.grep(/^\w*$/).sort_by { rand }.first(2).join ' '
    end

    def self.email
      LOREM.grep(/^\w*$/).sort_by { rand }.first(2).join('@') + ".com"
    end
  end
end

# pre-compute the insert statements and fake data compilation,
# so the benchmarks below show the actual runtime for the execute
# method, minus the setup steps

# Using the same paragraph for all exhibits because it is very slow
# to generate unique paragraphs for all exhibits.
notes = ActiveRecord::Faker::LOREM.join ' '
today = Date.today

puts "Inserting #{RECORDS} users and exhibits..."
RECORDS.times do
  user = User.create(
    :created_at => today,
    :name       => ActiveRecord::Faker.name,
    :email      => ActiveRecord::Faker.email
  )

  Exhibit.create(
    :created_at => today,
    :name       => ActiveRecord::Faker.name,
    :user       => user,
    :notes      => notes
  )
end

Benchmark.ips(TIME) do |x|
  ar_obj       = Exhibit.find(1)
  attrs        = { :name => 'sam' }
  attrs_first  = { :name => 'sam' }
  attrs_second = { :name => 'tom' }
  exhibit      = {
    :name       => ActiveRecord::Faker.name,
    :notes      => notes,
    :created_at => Date.today
  }

  x.report("Model#id") do
    ar_obj.id
  end

  x.report 'Model.new (instantiation)' do
    Exhibit.new
  end

  x.report 'Model.new (setting attributes)' do
    Exhibit.new(attrs)
  end

  x.report 'Model.first' do
    Exhibit.first.look
  end

  x.report("Model.all limit(100)") do
    Exhibit.look Exhibit.limit(100)
  end

  x.report "Model.all limit(100) with relationship" do
    Exhibit.feel Exhibit.limit(100).includes(:user)
  end

  x.report "Model.all limit(10,000)" do
    Exhibit.look Exhibit.limit(10000)
  end

  x.report 'Model.named_scope' do
    Exhibit.limit(10).with_name.with_notes
  end

  x.report 'Model.create' do
    Exhibit.create(exhibit)
  end

  x.report 'Resource#attributes=' do
    e = Exhibit.new(attrs_first)
    e.attributes = attrs_second
  end

  x.report 'Resource#update' do
    Exhibit.first.update(name: 'bob')
  end

  x.report 'Resource#destroy' do
    Exhibit.first.destroy
  end

  x.report 'Model.transaction' do
    Exhibit.transaction { Exhibit.new }
  end

  x.report 'Model.find(id)' do
    User.find(1)
  end

  x.report 'Model.find_by_sql' do
    Exhibit.find_by_sql("SELECT * FROM exhibits WHERE id = #{(rand * 1000 + 1).to_i}").first
  end

  x.report "Model.log" do
    Exhibit.connection.send(:log, "hello", "world") {}
  end

  x.report "AR.execute(query)" do
    ActiveRecord::Base.connection.execute("Select * from exhibits where id = #{(rand * 1000 + 1).to_i}")
  end
end