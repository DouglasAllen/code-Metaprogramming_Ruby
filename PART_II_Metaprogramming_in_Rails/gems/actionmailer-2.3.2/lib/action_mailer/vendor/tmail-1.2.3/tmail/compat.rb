#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
#:stopdoc:
unless Enumerable.method_defined?(:map) 
  module Enumerable #:nodoc:
    alias map collect
  end
end

unless Enumerable.method_defined?(:select)
  module Enumerable #:nodoc:
    alias select find_all
  end
end

unless Enumerable.method_defined?(:reject)
  module Enumerable #:nodoc:
    def reject
      result = []
      each do |i|
        result.push i unless yield(i)
      end
      result
    end
  end
end

unless Enumerable.method_defined?(:sort_by)
  module Enumerable #:nodoc:
    def sort_by
      map {|i| [yield(i), i] }.sort.map {|val, i| i }
    end
  end
end

unless File.respond_to?(:read)
  def File.read(fname) #:nodoc:
    File.open(fname) {|f|
      return f.read
    }
  end
end
#:startdoc: