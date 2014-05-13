class Parent
  def self.inherited(by)
    puts "#{self} was inherited by #{by}"
  end
end

class Child < Parent
end

class OtherChild < Parent
end
    