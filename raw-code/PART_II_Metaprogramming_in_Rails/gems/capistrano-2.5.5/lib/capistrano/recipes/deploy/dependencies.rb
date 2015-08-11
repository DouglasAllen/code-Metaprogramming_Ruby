#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'capistrano/recipes/deploy/local_dependency'
require 'capistrano/recipes/deploy/remote_dependency'

module Capistrano
  module Deploy
    class Dependencies
      include Enumerable

      attr_reader :configuration

      def initialize(configuration)
        @configuration = configuration
        @dependencies = []
        yield self if block_given?
      end

      def check
        yield self
        self
      end
  
      def remote
        dep = RemoteDependency.new(configuration)
        @dependencies << dep
        dep
      end

      def local
        dep = LocalDependency.new(configuration)
        @dependencies << dep
        dep
      end

      def each
        @dependencies.each { |d| yield d }
        self
      end

      def pass?
        all? { |d| d.pass? }
      end
    end
  end
end