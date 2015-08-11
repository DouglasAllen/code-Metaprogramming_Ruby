module TraceCalls 
  def self.included(klass)
    klass.const_set(:METHOD_HASH, {}) 
    klass.instance_methods(false).each do |method|
      wrap_method(klass, method.to_sym)
    end   
    def klass.method_added(name)    
      return if @_adding_a_method
      @_adding_a_method = true
      TraceCalls.wrap_method(self, name) 
      @_adding_a_method = false
    end
  end
  
  def self.wrap_method(klass, name)
    method_hash = klass.const_get(:METHOD_HASH) || fail("No method hash")
    method_hash[name] = klass.instance_method(name)
    klass.class_eval %{
      def #{name}(*args, &block)
        puts "==> Calling #{name} with \#{args.inspect} \#{'(and a block)' if block_given?}"
        result = METHOD_HASH[:#{name}].bind(self).call(*args, &block)
        puts "<<= returns \#{result.inspect}"
        result
      end
     }
  end
end

class Example
  include TraceCalls
  
  def some_method(arg1, arg2)
    if block_given?
      arg1 + arg2 + yield
    else
      arg1 + arg2
    end
  end 
  
  def some_attr=(val)
    @some_attr = val
  end 
  
  def <<(val)
    puts "Pushing #{val}"
  end
end   

ex = Example.new
ex.some_method(4,5) 
ex.some_method(4,5) { 6 }
ex.some_attr = 123
ex << "cat"
            
class Time
  include TraceCalls
end

puts Time.new + 24*3600