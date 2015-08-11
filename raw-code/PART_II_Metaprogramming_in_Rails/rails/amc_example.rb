#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class MyClass
  def greet
    puts "Hello"
  end
end

MyClass.new.greet

class MyClass
  def greet_with_log
    puts "Calling method..."
    greet_without_log
    puts "...Method called"
  end
  
  alias_method :greet_without_log, :greet
  alias_method :greet, :greet_with_log
end

MyClass.new.greet

MyClass.new.greet_without_log
