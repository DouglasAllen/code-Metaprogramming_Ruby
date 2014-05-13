#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'thread_safe'
require 'action_view/dependency_tracker'

module ActionView
  class Digestor
    cattr_reader(:cache)
    @@cache = ThreadSafe::Cache.new

    def self.digest(name, format, finder, options = {})
      cache_key = [name, format] + Array.wrap(options[:dependencies])
      @@cache[cache_key.join('.')] ||= begin
        klass = options[:partial] || name.include?("/_") ? PartialDigestor : Digestor
        klass.new(name, format, finder, options).digest
      end
    end

    attr_reader :name, :format, :finder, :options

    def initialize(name, format, finder, options={})
      @name, @format, @finder, @options = name, format, finder, options
    end

    def digest
      Digest::MD5.hexdigest("#{source}-#{dependency_digest}").tap do |digest|
        logger.try :info, "Cache digest for #{name}.#{format}: #{digest}"
      end
    rescue ActionView::MissingTemplate
      logger.try :error, "Couldn't find template for digesting: #{name}.#{format}"
      ''
    end

    def dependencies
      DependencyTracker.find_dependencies(name, template)
    rescue ActionView::MissingTemplate
      [] # File doesn't exist, so no dependencies
    end

    def nested_dependencies
      dependencies.collect do |dependency|
        dependencies = PartialDigestor.new(dependency, format, finder).nested_dependencies
        dependencies.any? ? { dependency => dependencies } : dependency
      end
    end

    private

      def logger
        ActionView::Base.logger
      end

      def logical_name
        name.gsub(%r|/_|, "/")
      end

      def partial?
        false
      end

      def template
        @template ||= finder.find(logical_name, [], partial?, formats: [ format ])
      end

      def source
        template.source
      end

      def dependency_digest
        template_digests = dependencies.collect do |template_name|
          Digestor.digest(template_name, format, finder, partial: true)
        end

        (template_digests + injected_dependencies).join("-")
      end

      def injected_dependencies
        Array.wrap(options[:dependencies])
      end
  end

  class PartialDigestor < Digestor # :nodoc:
    def partial?
      true
    end
  end
end
