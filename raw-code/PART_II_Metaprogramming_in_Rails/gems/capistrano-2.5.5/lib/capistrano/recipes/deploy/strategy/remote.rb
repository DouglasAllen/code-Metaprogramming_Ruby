#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'capistrano/recipes/deploy/strategy/base'

module Capistrano
  module Deploy
    module Strategy

      # An abstract superclass, which forms the base for all deployment
      # strategies which work by grabbing the code from the repository directly
      # from remote host. This includes deploying by checkout (the default),
      # and deploying by export.
      class Remote < Base
        # Executes the SCM command for this strategy and writes the REVISION
        # mark file to each host.
        def deploy!
          scm_run "#{command} && #{mark}"
        end

        def check!
          super.check do |d|
            d.remote.command(source.command)
          end
        end

        protected

          # Runs the given command, filtering output back through the
          # #handle_data filter of the SCM implementation.
          def scm_run(command)
            run(command) do |ch,stream,text|
              ch[:state] ||= { :channel => ch }
              output = source.handle_data(ch[:state], stream, text)
              ch.send_data(output) if output
            end
          end

          # An abstract method which must be overridden in subclasses, to
          # return the actual SCM command(s) which must be executed on each
          # target host in order to perform the deployment.
          def command
            raise NotImplementedError, "`command' is not implemented by #{self.class.name}"
          end

          # Returns the command which will write the identifier of the
          # revision being deployed to the REVISION file on each host.
          def mark
            "(echo #{revision} > #{configuration[:release_path]}/REVISION)"
          end
      end

    end
  end
end
