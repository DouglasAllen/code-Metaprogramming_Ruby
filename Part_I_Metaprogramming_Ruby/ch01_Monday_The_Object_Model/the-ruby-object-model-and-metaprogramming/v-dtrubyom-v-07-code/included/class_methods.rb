module Persistable
  module ClassMethods
    def find(param)  
      # ...
    end
  end
  
  def self.included(other)
    other.extend ClassMethods
  end
end

class Person
  include Persistable
end

Person.find(123)