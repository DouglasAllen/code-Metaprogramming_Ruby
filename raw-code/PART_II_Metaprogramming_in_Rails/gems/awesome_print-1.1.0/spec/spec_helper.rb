#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# Copyright (c) 2010-2012 Michael Dvorkin
#
# Awesome Print is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
#
# Running specs from the command line:
#   $ rake spec                   # Entire spec suite.
#   $ rspec spec/objects_spec.rb  # Individual spec file.
#
# NOTE: To successfully run specs with Ruby 1.8.6 the older versions of
# Bundler and RSpec gems are required:
#
# $ gem install bundler -v=1.0.2
# $ gem install rspec -v=2.6.0
#
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'awesome_print'

def stub_dotfile!
  dotfile = File.join(ENV["HOME"], ".aprc")
  File.should_receive(:readable?).at_least(:once).with(dotfile).and_return(false)
end

def capture!
  standard, $stdout = $stdout, StringIO.new
  yield
ensure
  $stdout = standard
end

# The following is needed for the Infinity Test. It runs tests as subprocesses,
# which sets STDOUT.tty? to false and would otherwise prematurely disallow colors.
### AwesomePrint.force_colors!

# Ruby 1.8.6 only: define missing String methods that are needed for the specs to pass.
if RUBY_VERSION < '1.8.7'
  class String
    def shellescape # Taken from Ruby 1.9.2 standard library, see lib/shellwords.rb.
      return "''" if self.empty?
      str = self.dup
      str.gsub!(/([^A-Za-z0-9_\-.,:\/@\n])/n, "\\\\\\1")
      str.gsub!(/\n/, "'\n'")
      str
    end

    def start_with?(*prefixes)
      prefixes.each do |prefix|
        prefix = prefix.to_s
        return true if prefix == self[0, prefix.size]
      end
      false
    end

    def end_with?(*suffixes)
      suffixes.each do |suffix|
        suffix = suffix.to_s
        return true if suffix == self[-suffix.size, suffix.size]
      end
      false
    end
  end
end
