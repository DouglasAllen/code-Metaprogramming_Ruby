#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
begin
  require 'rubygems'
  gem     'mocha'
rescue LoadError
end

require 'test/unit'
require 'mocha'
require 'capistrano/server_definition'

module TestExtensions
  def server(host, options={})
    Capistrano::ServerDefinition.new(host, options)
  end

  def namespace(fqn=nil)
    space = stub(:roles => {}, :fully_qualified_name => fqn, :default_task => nil)
    yield(space) if block_given?
    space
  end

  def role(space, name, *args)
    opts = args.last.is_a?(Hash) ? args.pop : {}
    space.roles[name] ||= []
    space.roles[name].concat(args.map { |h| Capistrano::ServerDefinition.new(h, opts) })
  end

  def new_task(name, namespace=@namespace, options={}, &block)
    block ||= Proc.new {}
    task = Capistrano::TaskDefinition.new(name, namespace, options, &block)
    assert_equal block, task.body
    return task
  end
end

class Test::Unit::TestCase
  include TestExtensions
end
