#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/deprecation'

class Object
  # Returns true if this object is included in the argument. Argument must be
  # any object which responds to +#include?+. Usage:
  #
  #   characters = ["Konata", "Kagami", "Tsukasa"]
  #   "Konata".in?(characters) # => true
  #
  # This will throw an ArgumentError if the argument doesn't respond
  # to +#include?+.
  def in?(*args)
    if args.length > 1
      ActiveSupport::Deprecation.warn "Calling #in? with multiple arguments is" \
        " deprecated, please pass in an object that responds to #include? instead."
      args.include? self
    else
      another_object = args.first
      if another_object.respond_to? :include?
        another_object.include? self
      else
        raise ArgumentError.new 'The single parameter passed to #in? must respond to #include?'
      end
    end
  end
end