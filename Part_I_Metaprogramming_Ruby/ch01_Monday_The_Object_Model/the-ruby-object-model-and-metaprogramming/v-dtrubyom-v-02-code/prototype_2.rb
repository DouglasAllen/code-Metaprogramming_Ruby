Animal = Object.new 

def Animal.food
  @food
end

def Animal.food=(food)
  @food = food
end

def Animal.that_eats(food)
  new_animal = clone
  new_animal.food = food 
  new_animal
end

Carnivore = Animal.that_eats(:meat)

lion = Carnivore.clone

p lion

