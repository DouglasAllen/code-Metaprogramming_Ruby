class Object             
  class << self
    original_const_missing = instance_method(:const_missing)
    looked_for = {}
    
    define_method(:const_missing) do |name| 
      if looked_for.has_key?(name)
        return original_const_missing.bind(self).call(name)
      else
        looked_for[name] = true
        file_name = name.to_s.gsub(/(\w)([A-Z])/) {"#{$1}_#{$2.downcase}"} .downcase
        require file_name
        const_get(name)
      end
    end   
  end
end                          

d = XDave.new
p d
