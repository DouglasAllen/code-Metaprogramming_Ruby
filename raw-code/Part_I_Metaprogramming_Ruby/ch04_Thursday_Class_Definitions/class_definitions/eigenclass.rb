#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
an_object = Object.new

class << an_object
  # your code here
end

obj = Object.new
eigenclass = class << obj
  self
end
eigenclass.class   # => Class

def obj.my_singleton_method; end
eigenclass.instance_methods.grep(/my_/)  # => ["my_singleton_method"]
