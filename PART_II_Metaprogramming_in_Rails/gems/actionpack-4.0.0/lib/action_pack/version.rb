#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActionPack
  # Returns the version of the currently loaded ActionPack as a Gem::Version
  def self.version
    Gem::Version.new "4.0.0"
  end

  module VERSION #:nodoc:
    MAJOR, MINOR, TINY, PRE = ActionPack.version.segments
    STRING = ActionPack.version.to_s
  end
end
