class Module
  def const_missing(name)
    puts "#{self} is missing #{name}"
    self.const_set(name, Class.new)
  end
end

class Object
  def self.const_missing(name)
    puts "OBJECT: #{self} is missing #{name}"
    super
  end
end


A::B::C::D   

class Dave
  def self.const_missing(name)
    puts "Dave is missing the constant #{name}"
  end
end

Dave::Something