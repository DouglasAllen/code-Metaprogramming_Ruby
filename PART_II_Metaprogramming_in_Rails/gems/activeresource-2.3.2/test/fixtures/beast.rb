#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
class BeastResource < ActiveResource::Base
  self.site = 'http://beast.caboo.se'
  site.user = 'foo'
  site.password = 'bar'
end

class Forum < BeastResource
  # taken from BeastResource
  # self.site = 'http://beast.caboo.se'
end

class Topic < BeastResource
  self.site += '/forums/:forum_id'
end
