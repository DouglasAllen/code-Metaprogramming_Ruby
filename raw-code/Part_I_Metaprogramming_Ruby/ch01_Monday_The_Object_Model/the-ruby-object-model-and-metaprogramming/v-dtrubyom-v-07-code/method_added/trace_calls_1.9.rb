module TraceCalls
  def self.included(klass)
    suppress_tracing do
      klass.instance_methods(false).each do |existing_method|
        wrap(klass, existing_method)
      end
    end
    def klass.method_added(method)  # note: nested definition
      unless @trace_calls_internal
        @trace_calls_internal = true
        TraceCalls.wrap(self, method)
        @trace_calls_internal = false
      end
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

  def self.wrap(klass, method) 
    klass.class_eval do
      name = method.to_s
      original_method = instance_method(name)

      define_method(name) do |*args, &block|
        if TraceCalls.ok_to_trace?
          TraceCalls.suppress_tracing do
            puts "==> Calling #{name} with #{args.inspect} #{'(and a block)' if block_given?}"
          end
        end
        result = original_method.bind(self).call(*args, &block)
        if TraceCalls.ok_to_trace?
          puts "<<= returns #{result}"
        end
        result
      end
    end
  end
end

class Array
  include TraceCalls
end       

class Time
  include TraceCalls
end
 
t = Time.now   
puts t
puts t + 3600
puts t <=> Time.now


class Example
  def one(arg)
    puts "One called with #{arg}"
  end
end

ex1 = Example.new
ex1.one("Hello")     # no tracing from this call

class Example
  include TraceCalls

  def two(arg1, arg2)
    arg1 + arg2
  end
end

ex1.one("Goodbye")   # but we see tracing from these two
puts ex1.two(4, 5) 

class String
  include TraceCalls
end

puts "cat" + "dog"
