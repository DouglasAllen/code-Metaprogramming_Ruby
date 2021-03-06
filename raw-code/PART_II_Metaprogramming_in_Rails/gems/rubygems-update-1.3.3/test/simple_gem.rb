#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
#--
# Copyright 2006 by Chad Fowler, Rich Kilmer, Jim Weirich and others.
# All rights reserved.
# See LICENSE.txt for permissions.
#++

    SIMPLE_GEM = <<-GEMDATA
        MD5SUM = "e3701f9db765a2358aef94c40ded71c8"
        if $0 == __FILE__
          require 'optparse'
        
          options = {}
          ARGV.options do |opts|
            opts.on_tail("--help", "show this message") {puts opts; exit}
            opts.on('--dir=DIRNAME', "Installation directory for the Gem") {|options[:directory]|}
            opts.on('--force', "Force Gem to intall, bypassing dependency checks") {|options[:force]|}
            opts.on('--gen-rdoc', "Generate RDoc documentation for the Gem") {|options[:gen_rdoc]|}
            opts.parse!
          end

          require 'rubygems'
          @directory = options[:directory] || Gem.dir  
          @force = options[:force]
  
          gem = Gem::Installer.new(__FILE__).install(@force, @directory)      
          if options[:gen_rdoc]
            Gem::DocManager.new(gem).generate_rdoc
          end
end

__END__
--- !ruby/object:Gem::Specification 
rubygems_version: "1.0"
name: testing
version: !ruby/object:Gem::Version 
  version: 1.2.3
date: 2004-03-18 22:01:52.859121 -05:00
platform: 
summary: This exercise the gem testing stuff.
require_paths: 
  - lib
files: 
  - lib/foo.rb
  - lib/test
  - lib/test.rb
  - lib/test/wow.rb
autorequire: test
test_suite_file: foo
requirements: 
  - a computer processor
--- 
- 
  size: 109
  mode: 420
  path: lib/foo.rb
- 
  size: 0
  mode: 420
  path: lib/test.rb
- 
  size: 15
  mode: 420
  path: lib/test/wow.rb
---
eJwVjDEKgDAUQ/eeIpsKguhY3ARPoHMp9quF0mL7e39/h5DwQpLpqz4TOqbC
U42eO6WuYEvBntIhECuaaX1KqXXLmy2kAEc32szExK+PjyBAlpTZyK0N/Twu
g1CKTjX9BGAj1w==
---
eJwDAAAAAAE=
---
eJwrKC0pVlAvzy9XyE3MU+cCACwiBP4=
    GEMDATA
