class Discounter
  def discount(*skus) 
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
