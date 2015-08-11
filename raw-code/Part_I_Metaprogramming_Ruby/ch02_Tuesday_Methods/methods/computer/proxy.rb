#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
# Computer as a Dynamic Proxy

require './data_source'

class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
  end
  def method_missing(name, *args)
    super if !@data_source.respond_to?("get_#{name}_info")
    info = @data_source.send("get_#{name}_info", args[0])
    price = @data_source.send("get_#{name}_price", args[0])
    result = "#{name.to_s.capitalize}: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end
end

cmp = Computer.new(0, DS.new)
cmp.respond_to?(:mouse)       # => false

class Computer
  def respond_to?(method)
    @data_source.respond_to?("get_#{method}_info") || super
  end

  # ...
end

cmp.respond_to?(:mouse)   # => true

require './unit_test'
