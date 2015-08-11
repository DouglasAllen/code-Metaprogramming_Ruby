#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
Spec::Matchers.constants.each do |c|
  if Class === (klass = Spec::Matchers.const_get(c))
    if klass.public_instance_methods.any? {|m| ['failure_message_for_should',:failure_message_for_should].include?(m)}
      klass.class_eval do
        alias_method :failure_message, :failure_message_for_should
      end
    end
    if klass.public_instance_methods.any? {|m| ['failure_message_for_should_not',:failure_message_for_should_not].include?(m)}
      klass.class_eval do
        alias_method :negative_failure_message, :failure_message_for_should_not
      end
    end
  end
end
