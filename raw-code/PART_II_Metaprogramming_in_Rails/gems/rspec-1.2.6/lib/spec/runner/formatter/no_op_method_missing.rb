#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module Spec
  module Runner
    module Formatter
      module NOOPMethodMissing
        def respond_to?(message, include_private = false)
          if include_private
            true
          else
            !private_methods.any? {|m| [message.to_s, message.to_sym].include?(m)}
          end
        end

      private
        
        def method_missing(sym, *args)
          # a no-op
        end
      end
    end
  end
end
