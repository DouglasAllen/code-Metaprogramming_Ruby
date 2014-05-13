#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
require 'highline'

# work around problem where HighLine detects an eof on $stdin and raises an
# error.
HighLine.track_eof = false

module Capistrano
  class CLI
    module UI
      def self.included(base) #:nodoc:
        base.extend(ClassMethods)
      end

      module ClassMethods
        # Return the object that provides UI-specific methods, such as prompts
        # and more.
        def ui
          @ui ||= HighLine.new
        end

        # Prompt for a password using echo suppression.
        def password_prompt(prompt="Password: ")
          ui.ask(prompt) { |q| q.echo = false }
        end
        
        # Debug mode prompt
        def debug_prompt(cmd)
          ui.say("Preparing to execute command: #{cmd}")
          prompt = "Execute ([Yes], No, Abort) "
          ui.ask("#{prompt}?  ") do |q|
            q.overwrite = false
            q.default = 'y'
            q.validate = /(y(es)?)|(no?)|(a(bort)?|\n)/i
            q.responses[:not_valid] = prompt
          end
        end
      end
    end
  end
end