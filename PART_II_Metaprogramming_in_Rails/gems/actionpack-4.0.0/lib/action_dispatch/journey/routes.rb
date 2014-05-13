#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActionDispatch
  module Journey # :nodoc:
    # The Routing table. Contains all routes for a system. Routes can be
    # added to the table by calling Routes#add_route.
    class Routes # :nodoc:
      include Enumerable

      attr_reader :routes, :named_routes

      def initialize
        @routes             = []
        @named_routes       = {}
        @ast                = nil
        @partitioned_routes = nil
        @simulator          = nil
      end

      def length
        routes.length
      end
      alias :size :length

      def last
        routes.last
      end

      def each(&block)
        routes.each(&block)
      end

      def clear
        routes.clear
      end

      def partitioned_routes
        @partitioned_routes ||= routes.partition do |r|
          r.path.anchored && r.ast.grep(Nodes::Symbol).all?(&:default_regexp?)
        end
      end

      def ast
        @ast ||= begin
          asts = partitioned_routes.first.map(&:ast)
          Nodes::Or.new(asts) unless asts.empty?
        end
      end

      def simulator
        @simulator ||= begin
          gtg = GTG::Builder.new(ast).transition_table
          GTG::Simulator.new(gtg)
        end
      end

      # Add a route to the routing table.
      def add_route(app, path, conditions, defaults, name = nil)
        route = Route.new(name, app, path, conditions, defaults)

        route.precedence = routes.length
        routes << route
        named_routes[name] = route if name && !named_routes[name]
        clear_cache!
        route
      end

      private

        def clear_cache!
          @ast                = nil
          @partitioned_routes = nil
          @simulator          = nil
        end
    end
  end
end
