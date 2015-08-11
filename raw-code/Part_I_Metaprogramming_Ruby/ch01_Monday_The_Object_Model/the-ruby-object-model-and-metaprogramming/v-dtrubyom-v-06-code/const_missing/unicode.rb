$KCODE = "u"
class Module
  original_const_missing = instance_method(:const_missing)
  
  define_method(:const_missing) do |name|
    if name.to_s =~ /^U([0-9a-fA-F]{4})$/
      [$1.to_i(16)].pack("U*")
    else
      original_const_missing.bind(self).call(name)
    end
  end
end

puts U0041 
puts U01AB