class Thing
  def initialize
    @var = 99
  end
  
  private
  
  def secret
    puts "I love Ruby"
  end
end

t = Thing.new

puts t.instance_eval("@var")
puts t.instance_eval { @var }
           
t.instance_eval { @var = "cat" }
puts t.instance_eval { @var }

t.instance_eval { secret }
           
class Other
  def meth1(thing)
    thing.instance_eval do
      puts @var
      meth2
    end
  end
  
  def meth2
  end
end

o = Other.new
o.meth1(t)      
