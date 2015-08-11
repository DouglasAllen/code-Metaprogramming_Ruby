module Memo
  def memoize :fun 
     define_method
  end

class Fibonacci
  def fib(n)
    if n < 3
      1
    else
      fib(n-1) + fib(n-2)
    end
  end
end

f = Fibonacci.new

puts f.fib(10)