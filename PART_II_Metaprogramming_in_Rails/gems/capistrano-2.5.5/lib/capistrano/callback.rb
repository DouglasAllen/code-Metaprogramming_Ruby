#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module Capistrano
  class Callback
    attr_reader :source, :options, :only, :except

    def initialize(source, options={})
      @source = source
      @options = options
      @only = Array(options[:only]).map { |v| v.to_s }
      @except = Array(options[:except]).map { |v| v.to_s }
    end

    def applies_to?(task)
      if task && only.any?
        return only.include?(task.fully_qualified_name)
      elsif task && except.any?
        return !except.include?(task.fully_qualified_name)
      else
        return true
      end
    end
  end

  class ProcCallback < Callback
    def call
      source.call
    end
  end

  class TaskCallback < Callback
    attr_reader :config

    def initialize(config, source, options={})
      super(source, options)
      @config = config
    end

    def call
      config.find_and_execute_task(source)
    end

    def applies_to?(task)
      super && (task.nil? || task.fully_qualified_name != source.to_s)
    end
  end
end