#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActionView
  module Template::Handlers
    class Builder
      # Default format used by Builder.
      class_attribute :default_format
      self.default_format = :xml

      def call(template)
        require_engine
        "xml = ::Builder::XmlMarkup.new(:indent => 2);" +
          "self.output_buffer = xml.target!;" +
          template.source +
          ";xml.target!;"
      end

      protected

      def require_engine
        @required ||= begin
          require "builder"
          true
        end
      end
    end
  end
end
