#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module ActiveResource
  module Formats
    module XmlFormat
      extend self

      def extension
        "xml"
      end

      def mime_type
        "application/xml"
      end

      def encode(hash, options={})
        hash.to_xml(options)
      end

      def decode(xml)
        from_xml_data(Hash.from_xml(xml))
      end

      private
        # Manipulate from_xml Hash, because xml_simple is not exactly what we
        # want for Active Resource.
        def from_xml_data(data)
          if data.is_a?(Hash) && data.keys.size == 1
            data.values.first
          else
            data
          end
        end
    end
  end
end
