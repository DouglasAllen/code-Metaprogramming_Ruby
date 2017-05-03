animal = Object.new

def animal.number_of_feet=(feet)
  @number_of_feet = feet
end

def animal.number_of_feet
  @number_of_feet
end

animal.number_of_feet = 4
puts animal.number_of_feet

cat = animal.clone
cat.number_of_feet = 4

felix = cat.clone
puts felix.number_of_feet
