#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveRecord::Associations::Builder
  class HasAndBelongsToMany < CollectionAssociation #:nodoc:
    def macro
      :has_and_belongs_to_many
    end

    def valid_options
      super + [:join_table, :association_foreign_key, :delete_sql, :insert_sql]
    end

    def build
      reflection = super
      define_destroy_hook
      reflection
    end

    def show_deprecation_warnings
      super

      [:delete_sql, :insert_sql].each do |name|
        if options.include? name
          ActiveSupport::Deprecation.warn("The :#{name} association option is deprecated. Please find an alternative (such as using has_many :through).")
        end
      end
    end

    def define_destroy_hook
      name = self.name
      model.send(:include, Module.new {
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def destroy_associations
            association(:#{name}).delete_all
            super
          end
        RUBY
      })
    end
  end
end
