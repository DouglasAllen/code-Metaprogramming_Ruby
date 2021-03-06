#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveRecord::Associations::Builder
  class BelongsTo < SingularAssociation #:nodoc:
    def macro
      :belongs_to
    end

    def valid_options
      super + [:foreign_type, :polymorphic, :touch]
    end

    def constructable?
      !options[:polymorphic]
    end

    def build
      reflection = super
      add_counter_cache_callbacks(reflection) if options[:counter_cache]
      add_touch_callbacks(reflection)         if options[:touch]
      reflection
    end

    def add_counter_cache_callbacks(reflection)
      cache_column = reflection.counter_cache_column
      foreign_key = reflection.foreign_key

      mixin.class_eval <<-CODE, __FILE__, __LINE__ + 1
        def belongs_to_counter_cache_after_create_for_#{name}
          if record = #{name}
            record.class.increment_counter(:#{cache_column}, record.id)
            @_after_create_counter_called = true
          end
        end

        def belongs_to_counter_cache_before_destroy_for_#{name}
          unless destroyed_by_association && destroyed_by_association.foreign_key.to_sym == #{foreign_key.to_sym.inspect}
            record = #{name}
            if record && !self.destroyed?
              record.class.decrement_counter(:#{cache_column}, record.id)
            end
          end
        end

        def belongs_to_counter_cache_after_update_for_#{name}
          if (@_after_create_counter_called ||= false)
            @_after_create_counter_called = false
          elsif self.#{foreign_key}_changed? && !new_record? && defined?(#{name.to_s.camelize})
            model = #{name.to_s.camelize}
            foreign_key_was = self.#{foreign_key}_was
            foreign_key = self.#{foreign_key}

            if foreign_key && model.respond_to?(:increment_counter)
              model.increment_counter(:#{cache_column}, foreign_key)
            end
            if foreign_key_was && model.respond_to?(:decrement_counter)
              model.decrement_counter(:#{cache_column}, foreign_key_was)
            end
          end
        end
      CODE

      model.after_create   "belongs_to_counter_cache_after_create_for_#{name}"
      model.before_destroy "belongs_to_counter_cache_before_destroy_for_#{name}"
      model.after_update   "belongs_to_counter_cache_after_update_for_#{name}"

      klass = reflection.class_name.safe_constantize
      klass.attr_readonly cache_column if klass && klass.respond_to?(:attr_readonly)
    end

    def add_touch_callbacks(reflection)
      mixin.class_eval <<-CODE, __FILE__, __LINE__ + 1
        def belongs_to_touch_after_save_or_destroy_for_#{name}
          foreign_key_field = #{reflection.foreign_key.inspect}
          old_foreign_id    = changed_attributes[foreign_key_field]

          if old_foreign_id
            klass      = association(#{name.inspect}).klass
            old_record = klass.find_by(klass.primary_key => old_foreign_id)

            if old_record
              old_record.touch #{options[:touch].inspect if options[:touch] != true}
            end
          end

          record = #{name}
          unless record.nil? || record.new_record?
            record.touch #{options[:touch].inspect if options[:touch] != true}
          end
        end
      CODE

      model.after_save    "belongs_to_touch_after_save_or_destroy_for_#{name}"
      model.after_touch   "belongs_to_touch_after_save_or_destroy_for_#{name}"
      model.after_destroy "belongs_to_touch_after_save_or_destroy_for_#{name}"
    end

    def valid_dependent_options
      [:destroy, :delete]
    end
  end
end
