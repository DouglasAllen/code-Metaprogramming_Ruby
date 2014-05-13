#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActionController
  class ActionControllerError < StandardError #:nodoc:
  end

  class BadRequest < ActionControllerError #:nodoc:
    attr_reader :original_exception

    def initialize(type = nil, e = nil)
      return super() unless type && e

      super("Invalid #{type} parameters: #{e.message}")
      @original_exception = e
      set_backtrace e.backtrace
    end
  end

  class RenderError < ActionControllerError #:nodoc:
  end

  class RoutingError < ActionControllerError #:nodoc:
    attr_reader :failures
    def initialize(message, failures=[])
      super(message)
      @failures = failures
    end
  end

  class ActionController::UrlGenerationError < RoutingError #:nodoc:
  end

  class MethodNotAllowed < ActionControllerError #:nodoc:
    def initialize(*allowed_methods)
      super("Only #{allowed_methods.to_sentence(:locale => :en)} requests are allowed.")
    end
  end

  class NotImplemented < MethodNotAllowed #:nodoc:
  end

  class UnknownController < ActionControllerError #:nodoc:
  end

  class MissingFile < ActionControllerError #:nodoc:
  end

  class SessionOverflowError < ActionControllerError #:nodoc:
    DEFAULT_MESSAGE = 'Your session data is larger than the data column in which it is to be stored. You must increase the size of your data column if you intend to store large data.'

    def initialize(message = nil)
      super(message || DEFAULT_MESSAGE)
    end
  end

  class UnknownHttpMethod < ActionControllerError #:nodoc:
  end

  class UnknownFormat < ActionControllerError #:nodoc:
  end
end
