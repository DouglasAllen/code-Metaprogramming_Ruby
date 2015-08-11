class Time;  def self.now;    Time.local(2008, 7, 24, 12, 23, 2);  end;end
module TraceCalls
  def self.included(klass)
    klass.const_set(:METHOD_HASH, {})
      klass.instance_methods(false).each do |meth|
        wrap_method(klass, meth.to_sym)
      end
    def klass.method_added(name)
      return if @_adding_a_method
      @_adding_a_method = true
      TraceCalls.wrap_method(self, name)
      @_adding_a_method = false
    end
  end 
  def self.wrap_method(klass, name) 
    method_hash = klass.const_get(:METHOD_HASH)
    method_hash[name] = klass.instance_method(name)
    body = %{
      def #{name}(*args, &block)
        puts "==> Calling #{name} with \#{args.inspect}"
        result = METHOD_HASH[:#{name}].bind(self).call(*args, &block)
        puts "<== result = \#{result}"
        result
      end
    }
    klass.class_eval body
  end  
end

class Time
  include TraceCalls
end

puts Time.now + 3600
# 
# class Example
#   include TraceCalls
#   
#   def some_method(arg1, arg2)
#     arg1 + arg2
#   end 
#   
#   def method2(arg)
#     yield * arg
#   end  
#   
#   def name=(name)
#     @name = name
#   end 
#   
#   def <<(thing)
#     puts "pushing #{thing}"
#   end
# end   
# 
# ex = Example.new
# ex.some_method(4,5)
# ex.method2(99) { 2 } 
# ex.name = "fred"
# ex << "cat"