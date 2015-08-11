#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActionView
  module Helpers
    module Tags # :nodoc:
      class Select < Base # :nodoc:
        def initialize(object_name, method_name, template_object, choices, options, html_options)
          @choices = choices
          @choices = @choices.to_a if @choices.is_a?(Range)
          @html_options = html_options

          super(object_name, method_name, template_object, options)
        end

        def render
          option_tags_options = {
            :selected => @options.fetch(:selected) { value(@object) },
            :disabled => @options[:disabled]
          }

          option_tags = if grouped_choices?
            grouped_options_for_select(@choices, option_tags_options)
          else
            options_for_select(@choices, option_tags_options)
          end

          select_content_tag(option_tags, @options, @html_options)
        end

        private

        # Grouped choices look like this:
        #
        #   [nil, []]
        #   { nil => [] }
        def grouped_choices?
          !@choices.empty? && @choices.first.respond_to?(:last) && Array === @choices.first.last
        end
      end
    end
  end
end
