Animal = Object.new 

def Animal.number_of_feet
  @number_of_feet
end

def Animal.number_of_feet=(feet)
  @number_of_feet = feet
end

def Animal.food
  @food
end

def Animal.food=(food)
  @food = food
end


Bird = Animal.clone
Bird.number_of_feet = 2
              
woodpecker = Bird.clone
woodpecker.food = 'insects'

p woodpecker
