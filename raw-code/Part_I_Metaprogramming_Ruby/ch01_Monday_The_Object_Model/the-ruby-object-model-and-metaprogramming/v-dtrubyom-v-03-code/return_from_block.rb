class Powers
  def self.to_the_power_n(name, exponent)
    define_method(name) do |val|
      if val <= 0
        return 0
      else
        val**exponent
      end
    end
  end
  
  to_the_power_n(:square, 2)

end  

pow = Powers.new

puts pow.square(3)
puts pow.square(-3)