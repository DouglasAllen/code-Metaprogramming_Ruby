#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
$:.push File.join(File.dirname(__FILE__), '..', 'lib')

# Deps
require 'rubygems'
require 'merb-core'
require 'merb-action-args'
require File.join(File.dirname(__FILE__), '..', 'lib', 'merb-cache')

Merb.disable(:initfile)

Merb.start :environment => "test",
           :adapter     => "runner",
           :log_file    => File.join(File.dirname(__FILE__), '..', 'log', 'merb_test.log')

require "merb-core/test"
Spec::Runner.configure do |config|
  config.include Merb::Test::Helpers
  #config.include Merb::Test::ControllerHelper
  config.include Merb::Test::RouteHelper
end

class DummyStore < Merb::Cache::AbstractStore
  cattr_accessor :vault
  attr_accessor  :options
  
  def initialize(config = {})
    super(config)
    @options = config
    @@vault = {}
  end

  def writable?(*args)
    true
  end

  def read(key, parameters = {})
        
    if @@vault.keys.include?(key)
      @@vault[key].find {|data, timestamp, conditions, params| params == parameters}
    end
  end

  def data(key, parameters = {})
    read(key, parameters)[0] if read(key, parameters)
  end

  def time(key, parameters = {})
    read(key, parameters)[1] if read(key, parameters)
  end

  def conditions(key, parameters = {})
    read(key, parameters)[2] if read(key, parameters)
  end

  def write(key, data = nil, parameters = {}, conditions = {})
    (@@vault[key] ||= []) << [data, Time.now, conditions, parameters]
    true
  end

  def fetch(key, parameters = {}, conditions = {}, &blk)
    @@vault[[key, parameters]] ||= blk.call
  end

  def exists?(key, parameters = {})
    @@vault.has_key? [key, parameters]
  end

  def delete(key, parameters = {})
    @@vault.delete([key, parameters]) unless @@vault[[key, parameters]].nil?
  end

  def delete_all
    @@vault = {}
  end
end

#TODO change this to a work queue per class called in an after aspect
class Merb::Controller
  def run_later
    yield
  end
end
