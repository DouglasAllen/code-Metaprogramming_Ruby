# p063xself2.rb  
class S  
  def m  
    puts "Class #{self.class} method #{eval(self.to_s)}:"   
  end  
end  
s = S.new  
s.m   
