
# docs go here
class Multiplier

  define_method(:times_2) do |val|
    val * 2
  end
end

m = Multiplier.new
puts m.times_2(3)
