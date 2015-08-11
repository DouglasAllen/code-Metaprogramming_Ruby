la = lambda {|a,b,c| }
# l.call(1,2)  #=> ArgumentError: wrong number of arguments (2 for 3)

pr = Proc.new {|a,b,c| p a, b, c}
#pr.call(1,2)  # 1, 2, nil

la = lambda { return }
la.call
puts "back"

la = Proc.new { return }
# la.call       # LocalJumpError: unexpected return
puts "back"

def fred block
  l = lambda { return }
  l.call
  puts "back1" 
  block.call   
  puts "backa"
  p1 = Proc.new { return } 
  p1.call
  puts "back2"
end

fred(lambda{ return }) 

def to_object(&block)
  block
end

blk = to_object {|a,b,c| return}
#blk.call(1,2)      # LocalJumpError: unexpected return