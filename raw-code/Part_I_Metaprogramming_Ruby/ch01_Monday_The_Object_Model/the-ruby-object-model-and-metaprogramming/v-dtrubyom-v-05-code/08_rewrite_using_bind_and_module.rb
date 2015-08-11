# Original idea probably due to Robert Feldt
module Memoize
  def remember(name)
    
    memory = {}
    
    original_method = instance_method(name)
    
    define_method(name) do |*args|
      if memory.has_key?(args)
        memory[args]
      else
        original = original_method.bind(self)
        memory[args] = original.call(*args)
      end
    end
  end
end      

class Discounter
  extend Memoize
  
  def discount(*skus) 
    expensive_discount_calculation(*skus)
  end                                       
  
  remember :discount
  
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