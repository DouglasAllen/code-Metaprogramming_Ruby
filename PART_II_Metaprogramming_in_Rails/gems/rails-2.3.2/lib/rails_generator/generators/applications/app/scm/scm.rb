#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Rails
  class Scm
    private
      def self.hash_to_parameters(hash)
        hash.collect { |key, value| "--#{key} #{(value.kind_of?(String) ? value : "")}"}.join(" ")
      end
  end
end