#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
module Spec
  module Matchers
    def self.last_matcher
      @last_matcher
    end

    def self.last_matcher=(last_matcher)
      @last_matcher = last_matcher
    end

    def self.last_should
      @last_should
    end

    def self.last_should=(last_should)
      @last_should = last_should
    end

    def self.clear_generated_description
      self.last_matcher = nil
      self.last_should = nil
    end

    def self.generated_description
      return nil if last_should.nil?
      "#{last_should.to_s.gsub('_',' ')} #{last_description}"
    end
    
    private
    
    def self.last_description
      last_matcher.respond_to?(:description) ? last_matcher.description : <<-MESSAGE
When you call a matcher in an example without a String, like this:

specify { object.should matcher }

or this:

it { should matcher }

the runner expects the matcher to have a #description method. You should either
add a String to the example this matcher is being used in, or give it a
description method. Then you won't have to suffer this lengthy warning again.
MESSAGE
    end
  end
end
      
