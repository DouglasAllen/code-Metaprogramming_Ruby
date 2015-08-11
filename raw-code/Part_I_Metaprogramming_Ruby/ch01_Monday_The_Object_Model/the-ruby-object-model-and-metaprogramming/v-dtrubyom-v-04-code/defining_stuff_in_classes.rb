module Hello
  def say_hello
    puts "hi from #{self.inspect}"
  end
end

[ String, Array, Hash ].each do |cls|
  cls.class_eval { include Hello }
end

"cat".say_hello
[1,2].say_hello
{ 1 => 2 }.say_hello