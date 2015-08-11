def count_with_increment(start, inc)
  start -= inc
  lambda { start += inc }
end

counter = count_with_increment(10,3)

puts counter.call    # => 10
puts counter.call    # => 13
puts counter.call    # => 16
