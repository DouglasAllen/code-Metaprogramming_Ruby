#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---

class MyClass
  puts 'Hello!'
  puts self
end
#>=Hello!

result = class MyClass
  #~ self
end
p result # => MyClass

class MyClass
# The current class is now MyClass...
  def my_method
  # ...so this is an instance method of MyClass
  end
end
p MyClass.methods(false)

def add_method_to(a_class)
# TODO: define method m() on a_class
end
p self.methods(false)

module MyModule
  puts 'Hello!'
  puts self
end 

def add_method_to(a_class)
  a_class.class_eval do
    def m; 'Hello!'; end
  end
end

add_method_to String
p "abc".m   # => "Hello!" 

self.send :display
puts
p self.send :to_s
p self.send :public
p self.send :private
p self.send :include