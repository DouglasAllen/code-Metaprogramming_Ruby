#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
class String
  alias :real_length :length
  
  def length
    real_length > 5 ? 'long' : 'short'
  end
end

"War and Peace".length      # => "long"
"War and Peace".real_length # => 13
