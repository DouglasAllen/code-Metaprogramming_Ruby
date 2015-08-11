#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
# Demonstrates building a parent controller which provides additional 'built in'
# formats, allowing anonymous formatter support to use the simple interface
# rather than the :format => FormatterClass approach.

require "ruport"
module FooCorp
  class Controller < Ruport::Controller
    def self.built_in_formats
      super.merge(:xml => FooCorp::Formatter::XML)
    end
  end

  class Formatter
    class XML < Ruport::Formatter

      def xmlify(stuff)
        output << "Wouldn't you like to see #{stuff} in XML?"
      end
    end
  end

  class MyController < FooCorp::Controller
    stage :foo

    formatter :xml do
      build :foo do
        xmlify "Red Snapper"
      end
    end

    formatter :text do
      build :foo do
        output << "Red Snapper"
      end
    end
  end
end

puts "XML:"
puts FooCorp::MyController.render_xml

puts "Text:"
puts FooCorp::MyController.render_text
