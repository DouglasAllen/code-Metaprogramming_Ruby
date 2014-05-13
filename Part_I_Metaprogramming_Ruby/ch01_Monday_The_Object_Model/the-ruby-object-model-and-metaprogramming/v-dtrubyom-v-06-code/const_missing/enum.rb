class Enum
  def self.new
    Class.new do
      def initialize(name)
        @name = name
      end
      def to_s
        "#{self.class.name}:#{@name}"
      end
      def self.const_missing(name)
        const_set(name, new(name))
      end
    end
  end
end

Color = Enum.new
p Color::Orange

ThreatLevel = Enum.new
puts ThreatLevel::Orange 

p Color::Orange