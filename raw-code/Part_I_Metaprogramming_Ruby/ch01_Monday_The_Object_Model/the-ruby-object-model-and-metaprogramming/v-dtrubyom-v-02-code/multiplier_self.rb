# docs go here
class Multiplier
  def self.create_multiplier
    define_method(:times_2) do |val|
      val * 2
    end
  end
  create_multiplier
end

m = Multiplier.new
puts m.times_2(3)