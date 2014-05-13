class Struct
  class << self
    attr_reader :children
    def inherited(by)
      (@children ||= []) << by
    end
  end
end

Dave = Struct.new(:name)
Fred = Struct.new(:age)

p Struct.children