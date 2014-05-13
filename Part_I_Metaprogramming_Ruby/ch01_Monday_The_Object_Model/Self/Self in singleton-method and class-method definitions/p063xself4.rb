# p063xself4.rb  
class S  
  def self.x  
    puts "Class method x() of class #{self}"  
    #~ puts self  
  end  
end
  
S.x 

self.send :display