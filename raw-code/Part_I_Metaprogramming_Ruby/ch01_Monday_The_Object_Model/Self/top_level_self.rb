# top_level_self.rb

x = 1  
# you have created a top level local variable x. 

#If you type:

def m  
end
  
# you have created a top level method - an instance method of Object (even though self is not Object).

# Top-level methods are always private. Ruby provides you with a start-up self at the top level. 

#If you type:

puts self
puts self.class
  
