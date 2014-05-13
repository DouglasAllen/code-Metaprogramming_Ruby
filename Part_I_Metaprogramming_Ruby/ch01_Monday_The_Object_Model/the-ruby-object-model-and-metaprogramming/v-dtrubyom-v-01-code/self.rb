class Silly
  def method_one
    @var = 99
    method_two
  end
  def method_two
    puts "@var is #{@var}"
  end
end

s = Silly.new
s.method_one 
