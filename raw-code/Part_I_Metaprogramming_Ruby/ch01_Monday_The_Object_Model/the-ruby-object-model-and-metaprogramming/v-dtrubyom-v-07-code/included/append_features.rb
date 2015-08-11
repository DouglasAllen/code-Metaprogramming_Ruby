class Object
  def self.append_features(*args)
    p args 
    super
  end
end

class Dave
  include Enumerable
end         

d = Dave.new
d.sort