#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :taggables, :through => :taggings
  has_one  :tagging

  has_many :tagged_posts, :through => :taggings, :source => :taggable, :source_type => 'Post'
end