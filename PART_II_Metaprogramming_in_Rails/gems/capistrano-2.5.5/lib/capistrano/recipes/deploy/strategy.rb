#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module Capistrano
  module Deploy
    module Strategy
      def self.new(strategy, config={})
        strategy_file = "capistrano/recipes/deploy/strategy/#{strategy}"
        require(strategy_file)

        strategy_const = strategy.to_s.capitalize.gsub(/_(.)/) { $1.upcase }
        if const_defined?(strategy_const)
          const_get(strategy_const).new(config)
        else
          raise Capistrano::Error, "could not find `#{name}::#{strategy_const}' in `#{strategy_file}'"
        end
      rescue LoadError
        raise Capistrano::Error, "could not find any strategy named `#{strategy}'"
      end
    end
  end
end