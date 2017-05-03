Person = Struct.new(:name, :likes) do
  def to_s
    "#{self.name} likes #{self.likes}"
  end
end

dave = Person.new("Dave", "Ruby")

puts dave