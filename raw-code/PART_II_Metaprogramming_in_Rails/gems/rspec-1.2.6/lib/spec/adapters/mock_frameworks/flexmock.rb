#!/usr/bin/env ruby
#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
#
#  Created by Jim Weirich on 2007-04-10.
#  Copyright (c) 2007. All rights reserved.

require 'rubygems' unless ENV['NO_RUBYGEMS']
require 'flexmock/rspec'

module Spec
  module Adapters
    module MockFramework
      include FlexMock::MockContainer
      def setup_mocks_for_rspec
        # No setup required
      end
      def verify_mocks_for_rspec
        flexmock_verify
      end
      def teardown_mocks_for_rspec
        flexmock_close
      end
    end
  end
end
