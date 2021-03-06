#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'action_view/record_identifier'

module ActionController
  module RecordIdentifier
    MODULE_MESSAGE = 'Calling ActionController::RecordIdentifier.%s is deprecated and ' \
      'will be removed in Rails 4.1, please call using ActionView::RecordIdentifier instead.'
    INSTANCE_MESSAGE = '%s method will no longer be included by default in controllers ' \
      'since Rails 4.1. If you would like to use it in controllers, please include ' \
      'ActionView::RecordIdentifier module.'

    def dom_id(record, prefix = nil)
      ActiveSupport::Deprecation.warn(INSTANCE_MESSAGE % 'dom_id')
      ActionView::RecordIdentifier.dom_id(record, prefix)
    end

    def dom_class(record, prefix = nil)
      ActiveSupport::Deprecation.warn(INSTANCE_MESSAGE % 'dom_class')
      ActionView::RecordIdentifier.dom_class(record, prefix)
    end

    def self.dom_id(record, prefix = nil)
      ActiveSupport::Deprecation.warn(MODULE_MESSAGE % 'dom_id')
      ActionView::RecordIdentifier.dom_id(record, prefix)
    end

    def self.dom_class(record, prefix = nil)
      ActiveSupport::Deprecation.warn(MODULE_MESSAGE % 'dom_class')
      ActionView::RecordIdentifier.dom_class(record, prefix)
    end
  end
end
