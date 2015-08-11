#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module Spec
  class << self
    def deprecate(method, alternate_method=nil)
       message = <<-NOTICE

*****************************************************************
DEPRECATION WARNING: you are using deprecated behaviour that will
be removed from a future version of RSpec.

#{caller(0)[2]}

* #{method} is deprecated.
NOTICE
      if alternate_method
        message << <<-ADDITIONAL
* please use #{alternate_method} instead.
ADDITIONAL
      end
      
      message << "*****************************************************************"
      warn(message)
    end
    
    def warn(message)
      Kernel.warn(message)
    end
    
  end

  class HashWithDeprecationNotice < Hash
    def initialize(method, alternate_method=nil, &block)
      @method, @alternate_method = method, alternate_method
    end
    def []=(k,v)
      Spec.deprecate(@method, @alternate_method)
      super
    end
  end
end

