#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
class DataTooShort < StandardError; end

class IoProcessor
  # Does some fancy stuff unless the length of +io+ is shorter than 32
  def process(io)
    raise DataTooShort if io.read.length < 32
  end
end
