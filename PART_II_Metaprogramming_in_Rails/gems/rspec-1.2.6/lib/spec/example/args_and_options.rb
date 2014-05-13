#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module Spec
  module Example
    module ArgsAndOptions
      def args_and_options(*args) # :nodoc:
        options = Hash === args.last ? args.pop : {}
        return args, options
      end

      def add_options(args, options={}) # :nodoc:
        args << {} unless Hash === args.last
        args.extend WithOptions
        args.options.merge!(options)
        args.options
      end
      
      def set_location(options, location) # :nodoc:
        options[:location] ||= location
      end

      module WithOptions # :nodoc:
        def options
          last
        end
      end
    end
  end
end
