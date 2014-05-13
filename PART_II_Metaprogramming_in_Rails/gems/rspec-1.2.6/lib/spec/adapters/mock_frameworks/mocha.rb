#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'rubygems' unless ENV['NO_RUBYGEMS']
require 'mocha/standalone'
require 'mocha/object'

module Spec
  module Adapters
    module MockFramework
      include Mocha::Standalone
      def setup_mocks_for_rspec
        mocha_setup
      end
      def verify_mocks_for_rspec
        mocha_verify
      end
      def teardown_mocks_for_rspec
        mocha_teardown
      end
    end
  end
end
