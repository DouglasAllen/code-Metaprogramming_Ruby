class BindingDemo
  def initialize
    @ivar = "wombat in instance variable"
  end
  def get_binding(param)
    lvar = "cat in local variable"
    binding
  end
end

b = BindingDemo.new

the_binding = b.get_binding("dog in paramater") { "elk in block" }

puts(eval("@ivar", the_binding))
puts(eval("lvar", the_binding))
puts(eval("param", the_binding))
puts(eval("yield", the_binding))

eval("lvar = 'new value'", the_binding)
puts(eval("lvar", the_binding))
    