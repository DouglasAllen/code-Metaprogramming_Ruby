#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
# http://media.pragprog.com/titles/ppmetr/code/introduction/introspection.rb ---
class Greeting

  def initialize(text)
    @text = text
  end
  
  def welcome
    @text
  end
  
end

p my_object = Greeting.new("Hello")
p my_object.class                             # => Greeting
p my_object.class.instance_methods(false)     # => [:welcome]
p my_object.instance_variables                # => [:@text]
