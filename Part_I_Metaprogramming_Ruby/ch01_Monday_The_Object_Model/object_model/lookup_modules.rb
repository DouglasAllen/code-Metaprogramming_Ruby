#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module M
  def my_method
    'M#my_method()'
  end
end

class C
  include M
end

class D < C; end

D.new.my_method() # => "M#my_method()"

D.ancestors # => [D, C, M, Object, Kernel, BasicObject]
