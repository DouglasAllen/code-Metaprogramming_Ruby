module TraceCalls 
  def self.included(klass)
    klass.const_set(:METHOD_HASH, {})
    suppress_tracing do 
      klass.instance_methods(false).each do |method|    
        wrap_method(klass, method.to_sym)
      end
    end   
    def klass.method_added(name)    
      return if @_adding_a_method
      @_adding_a_method = true
      TraceCalls.wrap_method(self, name) 
      @_adding_a_method = false
    end
  end

  def self.suppress_tracing
    Thread.current[:'suppress tracing'] = true
    yield
  ensure
    Thread.current[:'suppress tracing'] = false
  end

  def self.ok_to_trace?
    !Thread.current[:'suppress tracing']
  end      
  
  def self.wrap_method(klass, name)
    method_hash = klass.const_get(:METHOD_HASH) || fail("No method hash")
    method_hash[name] = klass.instance_method(name)
    klass.class_eval %{
      def #{name}(*args, &block)  
        if TraceCalls.ok_to_trace?
          TraceCalls.suppress_tracing do
            puts "==> Calling #{name} with \#{args.inspect} \#{'(and a block)' if block_given?}"
          end
        end
        result = METHOD_HASH[:#{name}].bind(self).call(*args, &block)
        if TraceCalls.ok_to_trace?
          puts "<<= returns \#{result}"
        end
        result
      end
     }
  end
end
    
class Array
  include TraceCalls
end

class One
  include TraceCalls
  def in_one
    t = Two.new
    t.in_two
  end
end

class Two
  include TraceCalls
  def in_two
    99
  end
end

One.new.in_one