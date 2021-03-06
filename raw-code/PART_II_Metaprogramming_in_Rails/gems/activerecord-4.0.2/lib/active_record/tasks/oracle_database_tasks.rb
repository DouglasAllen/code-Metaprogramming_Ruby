#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveRecord
  module Tasks # :nodoc:
    class OracleDatabaseTasks # :nodoc:
      delegate :connection, :establish_connection, to: ActiveRecord::Base

      def initialize(configuration)
        ActiveSupport::Deprecation.warn "This database tasks were deprecated, because this tasks should be served by the 3rd party adapter."
        @configuration = configuration
      end

      def create
        $stderr.puts 'sorry, your database adapter is not supported yet, feel free to submit a patch'
      end

      def drop
        $stderr.puts 'sorry, your database adapter is not supported yet, feel free to submit a patch'
      end

      def purge
        establish_connection(:test)
        connection.structure_drop.split(";\n\n").each { |ddl| connection.execute(ddl) }
      end

      def charset
        $stderr.puts 'sorry, your database adapter is not supported yet, feel free to submit a patch'
      end

      def structure_dump(filename)
        establish_connection(configuration)
        File.open(filename, "w:utf-8") { |f| f << connection.structure_dump }
      end

      def structure_load(filename)
        establish_connection(configuration)
        IO.read(filename).split(";\n\n").each { |ddl| connection.execute(ddl) }
      end

      private

      def configuration
        @configuration
      end
    end
  end
end
