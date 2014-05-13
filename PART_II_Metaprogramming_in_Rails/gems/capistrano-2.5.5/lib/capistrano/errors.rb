#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module Capistrano
  class Error < RuntimeError; end

  class CaptureError < Error; end
  class NoSuchTaskError < Error; end
  class NoMatchingServersError < Error; end
  
  class RemoteError < Error
    attr_accessor :hosts
  end

  class ConnectionError < RemoteError; end
  class TransferError < RemoteError; end
  class CommandError < RemoteError; end
end
