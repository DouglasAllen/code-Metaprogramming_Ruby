#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'spec'

if Spec::Ruby.version.to_f >= 1.9
  gem 'test-unit','1.2.3'
end

require 'test/unit'
require 'test/unit/testresult'

require 'spec/interop/test/unit/testcase'
require 'spec/interop/test/unit/testsuite_adapter'
require 'spec/interop/test/unit/autorunner'
require 'spec/interop/test/unit/testresult'
require 'spec/interop/test/unit/ui/console/testrunner'

Spec::Example::ExampleGroupFactory.default(Test::Unit::TestCase)

Test::Unit.run = true
