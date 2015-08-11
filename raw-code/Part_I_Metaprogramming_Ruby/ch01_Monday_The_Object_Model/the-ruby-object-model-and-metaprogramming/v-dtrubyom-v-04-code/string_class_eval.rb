String.class_eval do
  puts self
end

String.class_eval do
  def with_cat
    "kitty says: " + self
  end
end

puts "miaow".with_cat