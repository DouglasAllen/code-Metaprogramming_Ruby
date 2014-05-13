#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'rack/utils'

module Rails
  module Rack
    class Static
      FILE_METHODS = %w(GET HEAD).freeze

      def initialize(app)
        @app = app
        @file_server = ::Rack::File.new(File.join(RAILS_ROOT, "public"))
      end

      def call(env)
        path        = env['PATH_INFO'].chomp('/')
        method      = env['REQUEST_METHOD']

        if FILE_METHODS.include?(method)
          if file_exist?(path)
            return @file_server.call(env)
          else
            cached_path = directory_exist?(path) ? "#{path}/index" : path
            cached_path += ::ActionController::Base.page_cache_extension

            if file_exist?(cached_path)
              env['PATH_INFO'] = cached_path
              return @file_server.call(env)
            end
          end
        end

        @app.call(env)
      end

      private
        def file_exist?(path)
          full_path = File.join(@file_server.root, ::Rack::Utils.unescape(path))
          File.file?(full_path) && File.readable?(full_path)
        end

        def directory_exist?(path)
          full_path = File.join(@file_server.root, ::Rack::Utils.unescape(path))
          File.directory?(full_path) && File.readable?(full_path)
        end
    end
  end
end
