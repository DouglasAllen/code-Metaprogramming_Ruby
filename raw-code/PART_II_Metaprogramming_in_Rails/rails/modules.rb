#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'activerecord'
ActiveRecord::Base  # autoload all modules

class MyClass
  def save; end
  def save!; end
  def new_record?; true; end

  include ActiveRecord::Validations

  attr_accessor :attr
  validates_length_of :attr, :minimum => 4
end

obj = MyClass.new
obj.attr = 'test'
p obj.valid?        # => true
obj.attr = 'tst'
p obj.valid?        # => false
