#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/spec_helper'
class FileAccessor
  def open_and_handle_with(pathname, processor)
    pathname.open do |io|
      processor.process(io)
    end
  end
end

if __FILE__ == $0
  require File.dirname(__FILE__) + '/io_processor'
  require 'pathname'
  
  accessor = FileAccessor.new
  io_processor = IoProcessor.new
  file = Pathname.new ARGV[0]

  accessor.open_and_handle_with(file, io_processor)
end
