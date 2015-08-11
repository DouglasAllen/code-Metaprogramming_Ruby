#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require "action_view"
require "rails"

module ActionView
  # = Action View Railtie
  class Railtie < Rails::Railtie # :nodoc:
    config.action_view = ActiveSupport::OrderedOptions.new
    config.action_view.embed_authenticity_token_in_remote_forms = false

    config.eager_load_namespaces << ActionView

    initializer "action_view.embed_authenticity_token_in_remote_forms" do |app|
      ActiveSupport.on_load(:action_view) do
        ActionView::Helpers::FormTagHelper.embed_authenticity_token_in_remote_forms =
          app.config.action_view.delete(:embed_authenticity_token_in_remote_forms)
      end
    end

    initializer "action_view.logger" do
      ActiveSupport.on_load(:action_view) { self.logger ||= Rails.logger }
    end

    initializer "action_view.set_configs" do |app|
      ActiveSupport.on_load(:action_view) do
        app.config.action_view.each do |k,v|
          send "#{k}=", v
        end
      end
    end

    initializer "action_view.caching" do |app|
      ActiveSupport.on_load(:action_view) do
        if app.config.action_view.cache_template_loading.nil?
          ActionView::Resolver.caching = app.config.cache_classes
        end
      end
    end
  end
end
