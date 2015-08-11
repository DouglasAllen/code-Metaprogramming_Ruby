#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
$VERBOSE = nil

# Load Rails rakefile extensions
Dir["#{File.dirname(__FILE__)}/*.rake"].each { |ext| load ext }

# Load any custom rakefile extensions
Dir["#{RAILS_ROOT}/vendor/plugins/*/**/tasks/**/*.rake"].sort.each { |ext| load ext }
Dir["#{RAILS_ROOT}/lib/tasks/**/*.rake"].sort.each { |ext| load ext }
