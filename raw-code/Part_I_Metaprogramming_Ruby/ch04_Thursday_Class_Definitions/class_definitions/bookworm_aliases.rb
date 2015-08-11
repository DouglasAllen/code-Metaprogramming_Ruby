#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
class Amazon
  def reviews_of; ['one', 'two'] end
end

class Amazon
  alias :old_reviews_of :reviews_of
  def reviews_of(book)
      start = Time.now
      result = old_reviews_of book
      time_taken = Time.now - start
      puts "reviews_of() took more than #{time_taken} seconds" if time_taken > 2
      result
    rescue
      puts "reviews_of() failed"
      []
  end
end

def deserves_a_look?(book)
  amazon = Amazon.new
  amazon.reviews_of(book).size > 20
end

book = Object.new
deserves_a_look? book      # => false
