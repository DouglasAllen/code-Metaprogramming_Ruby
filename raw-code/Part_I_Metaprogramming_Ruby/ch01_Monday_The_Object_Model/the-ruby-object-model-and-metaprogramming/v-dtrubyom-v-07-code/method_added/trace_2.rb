module TraceCalls
  def self.included(klass)
    def klass.method_added(name)    
      return if @_adding_a_method
      @_adding_a_method = true
      TraceCalls.wrap_method(self, name) 
      @_adding_a_method = false
    end
  end
  
  def self.wrap_method(klass, name)
    original_method = "_original_#{name}"
    klass.class_eval %{
      alias_method :#{original_method}, :#{name} 
      def #{name}(*args, &block)
        puts "==> Calling #{name} with \#{args.inspect} \#{'(and a block)' if block_given?}"
        result = #{original_method}(*args, &block)
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
  
  # def some_attr=(val)
  #   @some_attr = val
  # end
end   

ex = Example.new
ex.some_method(4,5) 
ex.some_method(4,5) { 6 }
#ex.some_attr = 123
