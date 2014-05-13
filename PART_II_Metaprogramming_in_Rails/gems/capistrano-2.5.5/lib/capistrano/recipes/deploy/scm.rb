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
    module SCM
      def self.new(scm, config={})
        scm_file = "capistrano/recipes/deploy/scm/#{scm}"
        require(scm_file)

        scm_const = scm.to_s.capitalize.gsub(/_(.)/) { $1.upcase }
        if const_defined?(scm_const)
          const_get(scm_const).new(config)
        else
          raise Capistrano::Error, "could not find `#{name}::#{scm_const}' in `#{scm_file}'"
        end
      rescue LoadError
        raise Capistrano::Error, "could not find any SCM named `#{scm}'"
      end
    end
  end
end