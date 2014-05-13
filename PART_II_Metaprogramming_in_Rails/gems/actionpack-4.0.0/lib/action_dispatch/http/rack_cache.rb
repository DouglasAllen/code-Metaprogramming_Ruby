#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require "rack/cache"
require "rack/cache/context"
require "active_support/cache"

module ActionDispatch
  class RailsMetaStore < Rack::Cache::MetaStore
    def self.resolve(uri)
      new
    end

    def initialize(store = Rails.cache)
      @store = store
    end

    def read(key)
      if data = @store.read(key)
        Marshal.load(data)
      else
        []
      end
    end

    def write(key, value)
      @store.write(key, Marshal.dump(value))
    end

    ::Rack::Cache::MetaStore::RAILS = self
  end

  class RailsEntityStore < Rack::Cache::EntityStore
    def self.resolve(uri)
      new
    end

    def initialize(store = Rails.cache)
      @store = store
    end

    def exist?(key)
      @store.exist?(key)
    end

    def open(key)
      @store.read(key)
    end

    def read(key)
      body = open(key)
      body.join if body
    end

    def write(body)
      buf = []
      key, size = slurp(body) { |part| buf << part }
      @store.write(key, buf)
      [key, size]
    end

    ::Rack::Cache::EntityStore::RAILS = self
  end
end
