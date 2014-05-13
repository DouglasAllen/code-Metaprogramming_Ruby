#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'digest'

class Hash
  
  def to_sha2
    string = ""
    keys.sort_by{|k| k.to_s}.each do |k| 
      case self[k]
      when Array
        string << self[k].join
      when Hash
        string << self[k].to_sha2
      else
        string << self[k].to_s
      end
    end
    Digest::SHA2.hexdigest(string)
  end
  
end