#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'shellwords'

module ActiveRecord
  module Tasks # :nodoc:
    class SqlserverDatabaseTasks # :nodoc:
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
        test = configuration.deep_dup
        test_database = test['database']
        test['database'] = 'master'
        establish_connection(test)
        connection.recreate_database!(test_database)
      end

      def charset
        $stderr.puts 'sorry, your database adapter is not supported yet, feel free to submit a patch'
      end

      def structure_dump(filename)
        Kernel.system("smoscript -s #{configuration['host']} -d #{configuration['database']} -u #{configuration['username']} -p #{configuration['password']} -f #{filename} -A -U")
      end

      def structure_load(filename)
        Kernel.system("sqlcmd -S #{configuration['host']} -d #{configuration['database']} -U #{configuration['username']} -P #{configuration['password']} -i #{filename}")
      end

      private

      def configuration
        @configuration
      end
    end
  end
end
