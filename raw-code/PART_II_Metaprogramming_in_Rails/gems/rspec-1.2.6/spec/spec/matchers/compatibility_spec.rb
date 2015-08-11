#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require File.dirname(__FILE__) + '/../../spec_helper.rb'

Spec::Matchers.define :have_public_instance_method do |method|
  match do |klass|
    klass.public_instance_methods.any? {|m| [method, method.to_sym].include?(m)}
  end
end

(Spec::Matchers.constants.sort).each do |c|
  if (Class === (klass = Spec::Matchers.const_get(c)))
    describe klass do
      if klass.public_instance_methods.any? {|m| ['failure_message_for_should',:failure_message_for_should].include?(m)}
        describe "called with should" do
          subject { klass }
          it { should have_public_instance_method('failure_message_for_should')}
          it { should have_public_instance_method('failure_message')}
        end
      end
      if klass.public_instance_methods.any? {|m| ['failure_message_for_should_not',:failure_message_for_should_not].include?(m)}
        describe "called with should not" do
          subject { klass }
          it { should have_public_instance_method('failure_message_for_should_not')}
          it { should have_public_instance_method('negative_failure_message')}
        end
      end
    end
  end
end
