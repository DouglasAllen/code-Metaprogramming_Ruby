#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos

      module Collaborators
        class Proxy < ::Ghee::ResourceProxy
          def add(member)
            connection.put("#{path_prefix}/#{member}").status == 204
          end

          def remove(member)
            connection.delete("#{path_prefix}/#{member}").status == 204
          end
        end
      end

      # Gists::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy
        def collaborators(user=nil)
          prefix = user ? "#{path_prefix}/collaborators/#{user}" : "#{path_prefix}/collaborators"
          return user ?  connection.get(prefix).status == 204 : Ghee::API::Repos::Collaborators::Proxy.new(connection, prefix)
        end
      end

    end
  end
end
