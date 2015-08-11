#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Array
  # *DEPRECATED*: Use <tt>Array#uniq</tt> instead.
  #
  # Returns a unique array based on the criteria in the block.
  #
  #   [1, 2, 3, 4].uniq_by { |i| i.odd? } # => [1, 2]
  def uniq_by(&block)
    ActiveSupport::Deprecation.warn 'uniq_by is deprecated. Use Array#uniq instead'
    uniq(&block)
  end

  # *DEPRECATED*: Use <tt>Array#uniq!</tt> instead.
  #
  # Same as +uniq_by+, but modifies +self+.
  def uniq_by!(&block)
    ActiveSupport::Deprecation.warn 'uniq_by! is deprecated. Use Array#uniq! instead'
    uniq!(&block)
  end
end
