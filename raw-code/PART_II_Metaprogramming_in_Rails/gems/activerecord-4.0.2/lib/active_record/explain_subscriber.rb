#---
# Excerpted from "Metaprogramming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/notifications'
require 'active_record/explain_registry'

module ActiveRecord
  class ExplainSubscriber # :nodoc:
    def start(name, id, payload)
      # unused
    end

    def finish(name, id, payload)
      if ExplainRegistry.collect? && !ignore_payload?(payload)
        ExplainRegistry.queries << payload.values_at(:sql, :binds)
      end
    end

    # SCHEMA queries cannot be EXPLAINed, also we do not want to run EXPLAIN on
    # our own EXPLAINs now matter how loopingly beautiful that would be.
    #
    # On the other hand, we want to monitor the performance of our real database
    # queries, not the performance of the access to the query cache.
    IGNORED_PAYLOADS = %w(SCHEMA EXPLAIN CACHE)
    EXPLAINED_SQLS = /\A\s*(select|update|delete|insert)\b/i
    def ignore_payload?(payload)
      payload[:exception] || IGNORED_PAYLOADS.include?(payload[:name]) || payload[:sql] !~ EXPLAINED_SQLS
    end

    ActiveSupport::Notifications.subscribe("sql.active_record", new)
  end
end