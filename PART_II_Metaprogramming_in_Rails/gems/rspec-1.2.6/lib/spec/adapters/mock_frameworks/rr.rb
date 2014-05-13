#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'rubygems' unless ENV['NO_RUBYGEMS']
require 'rr'

patterns = ::Spec::Runner::QuietBacktraceTweaker::IGNORE_PATTERNS
patterns.push(RR::Errors::BACKTRACE_IDENTIFIER)

module Spec
  module Adapters
    module MockFramework
      include RR::Extensions::InstanceMethods
      def setup_mocks_for_rspec
        RR::Space.instance.reset
      end
      def verify_mocks_for_rspec
        RR::Space.instance.verify_doubles
      end
      def teardown_mocks_for_rspec
        RR::Space.instance.reset
      end
    end
  end
end
