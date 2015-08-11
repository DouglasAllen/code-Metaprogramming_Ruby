require 'date'

class Person
  
  def initialize(name, dob)
    @name = name
    @dob  = Date.parse(dob)
  end
  
  def age
    # ...
  end
  
  def marry(someone)
    # ...
  end
end
             
fred = Person.new("Fred", "1967-12-25")
p fred