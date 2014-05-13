#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
# Require everything except the global extensions of class and object. This
# supports wrapping rspec's mocking functionality without invading every
# object in the system.

require 'spec/mocks/methods'
require 'spec/mocks/argument_matchers'
require 'spec/mocks/spec_methods'
require 'spec/mocks/proxy'
require 'spec/mocks/mock'
require 'spec/mocks/argument_expectation'
require 'spec/mocks/message_expectation'
require 'spec/mocks/order_group'
require 'spec/mocks/errors'
require 'spec/mocks/error_generator'
require 'spec/mocks/space'
