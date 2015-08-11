#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActionController
  module Railties
    module Helpers
      def inherited(klass)
        super
        return unless klass.respond_to?(:helpers_path=)

        if namespace = klass.parents.detect { |m| m.respond_to?(:railtie_helpers_paths) }
          paths = namespace.railtie_helpers_paths
        else
          paths = ActionController::Helpers.helpers_path
        end

        klass.helpers_path = paths

        if klass.superclass == ActionController::Base && ActionController::Base.include_all_helpers
          klass.helper :all
        end
      end
    end
  end
end
