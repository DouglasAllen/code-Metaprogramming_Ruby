module TraceCalls
  def self.included(klass)
    def klass.method_added(name)    
      return if @_adding_a_method
      @_adding_a_method = true
      original_method = "original #{name}"
      alias_method original_method, name
      define_method(name) do |*args|
        puts "==> Calling #{name} with #{args.inspect}"
        result = send original_method, *args
        puts "<<= returns #{result.inspect}"
        result
      end
      @_adding_a_method = false
    end
  end
end

class Example
  include TraceCalls
  
  def some_method(arg1, arg2)
    arg1 + arg2
  end
end   

ex = Example.new
ex.some_method(4,5)
