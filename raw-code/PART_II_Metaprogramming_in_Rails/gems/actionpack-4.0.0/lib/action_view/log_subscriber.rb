#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActionView
  # = Action View Log Subscriber
  #
  # Provides functionality so that Rails can output logs from Action View.
  class LogSubscriber < ActiveSupport::LogSubscriber
    VIEWS_PATTERN = /^app\/views\//.freeze

    def render_template(event)
      return unless logger.info?
      message = "  Rendered #{from_rails_root(event.payload[:identifier])}"
      message << " within #{from_rails_root(event.payload[:layout])}" if event.payload[:layout]
      message << " (#{event.duration.round(1)}ms)"
      info(message)
    end
    alias :render_partial :render_template
    alias :render_collection :render_template

    def logger
      ActionView::Base.logger
    end

  protected

    def from_rails_root(string)
      string.sub("#{Rails.root}/", "").sub(VIEWS_PATTERN, "")
    end
  end
end

ActionView::LogSubscriber.attach_to :action_view
