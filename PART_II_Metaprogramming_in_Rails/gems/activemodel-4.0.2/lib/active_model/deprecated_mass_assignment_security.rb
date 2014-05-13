#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveModel
  module DeprecatedMassAssignmentSecurity # :nodoc:
    extend ActiveSupport::Concern

     module ClassMethods # :nodoc:
       def attr_protected(*args)
         raise "`attr_protected` is extracted out of Rails into a gem. " \
           "Please use new recommended protection model for params" \
           "(strong_parameters) or add `protected_attributes` to your " \
           "Gemfile to use old one."
       end

       def attr_accessible(*args)
         raise "`attr_accessible` is extracted out of Rails into a gem. " \
           "Please use new recommended protection model for params" \
           "(strong_parameters) or add `protected_attributes` to your " \
           "Gemfile to use old one."
       end
     end
  end
end
