#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'rubygems'
require 'test/unit'

gem 'mocha', '>= 0.9.5'
require 'mocha'

$:.unshift "#{File.dirname(__FILE__)}/../lib"
$:.unshift "#{File.dirname(__FILE__)}/../../activesupport/lib"
$:.unshift "#{File.dirname(__FILE__)}/../../actionpack/lib"
require 'action_mailer'
require 'action_mailer/test_case'

# Show backtraces for deprecated behavior for quicker cleanup.
ActiveSupport::Deprecation.debug = true

# Bogus template processors
ActionView::Template.register_template_handler :haml, lambda { |template| "Look its HAML!".inspect }
ActionView::Template.register_template_handler :bak, lambda { |template| "Lame backup".inspect }

$:.unshift "#{File.dirname(__FILE__)}/fixtures/helpers"

ActionView::Base.cache_template_loading = true
FIXTURE_LOAD_PATH = File.join(File.dirname(__FILE__), 'fixtures')
ActionMailer::Base.template_root = FIXTURE_LOAD_PATH

class MockSMTP
  def self.deliveries
    @@deliveries
  end

  def initialize
    @@deliveries = []
  end

  def sendmail(mail, from, to)
    @@deliveries << [mail, from, to]
  end

  def start(*args)
    yield self
  end
end

class Net::SMTP
  def self.new(*args)
    MockSMTP.new
  end
end

def uses_gem(gem_name, test_name, version = '> 0')
  gem gem_name.to_s, version
  require gem_name.to_s
  yield
rescue LoadError
  $stderr.puts "Skipping #{test_name} tests. `gem install #{gem_name}` and try again."
end

def set_delivery_method(delivery_method)
  @old_delivery_method = ActionMailer::Base.delivery_method
  ActionMailer::Base.delivery_method = delivery_method
end

def restore_delivery_method
  ActionMailer::Base.delivery_method = @old_delivery_method
end
