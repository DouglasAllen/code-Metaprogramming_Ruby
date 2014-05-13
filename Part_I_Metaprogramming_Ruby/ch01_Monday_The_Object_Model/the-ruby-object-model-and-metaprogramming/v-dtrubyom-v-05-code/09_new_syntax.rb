module Memoize
  def remember(name, &block)
    
    memory = {}
    
    define_method(name, &block) 
    meth = instance_method(name)
    
    define_method(name) do |*args|
      if memory.has_key?(args)
        memory[args]
      else
        memory[args] = meth.bind(self).call(*args)
      end
    end
  end
end      

class Discounter
  extend Memoize
  
  remember :discount do |*skus|
    expensive_discount_calculation(*skus)
  end                                       
  
  private
  
  def expensive_discount_calculation(*skus)
    puts "Expensive calculation for #{skus.inspect}"
    skus.inject {|m,n| m + n }
  end
end


d = Discounter.new
puts d.discount(1,2,3)
puts d.discount(1,2,3)
puts d.discount(2,3,4)
puts d.discount(2,3,4)      

d1 = Discounter.new
puts d.discount(1,2,3)