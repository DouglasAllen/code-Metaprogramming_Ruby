#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'spec/interop/test'

# Hack to stop active_support/dependencies from complaining about
# 'spec/test/unit' not defining Spec::Test::Unit
module Spec
  module Test
    module Unit
    end
  end
end
