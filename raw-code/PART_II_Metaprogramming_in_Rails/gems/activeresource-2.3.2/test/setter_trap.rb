#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
class SetterTrap < ActiveSupport::BasicObject
  class << self
    def rollback_sets(obj)
      trapped = new(obj)
      yield(trapped).tap { trapped.rollback_sets }
    end
  end

  def initialize(obj)
    @cache = {}
    @obj = obj
  end

  def respond_to?(method)
    @obj.respond_to?(method)
  end

  def method_missing(method, *args, &proc)
    @cache[method] ||= @obj.send($`) if method.to_s =~ /=$/
    @obj.send method, *args, &proc
  end

  def rollback_sets
    @cache.each { |k, v| @obj.send k, v }
  end
end
