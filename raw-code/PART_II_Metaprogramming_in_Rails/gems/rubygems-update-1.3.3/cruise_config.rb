#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
# Project-specific configuration for CruiseControl.rb

Project.configure do |project|
  
  # Send email notifications about broken and fixed builds to email1@your.site, email2@your.site (default: send to nobody)
  project.email_notifier.emails = ['rubygems-developers@rubyforge.org']

  # Set email 'from' field to john@doe.com:
  project.email_notifier.from = 'devnull+rubygems-ci@pivotallabs.com'

  # Build the project by invoking rake task 'custom'
  # project.rake_task = 'custom'

  # Build the project by invoking shell script "build_my_app.sh". Keep in mind that when the script is invoked,
  # current working directory is <em>[cruise&nbsp;data]</em>/projects/your_project/work, so if you do not keep build_my_app.sh
  # in version control, it should be '../build_my_app.sh' instead
  # project.build_command = 'build_my_app.sh'

  # Ping Subversion for new revisions every 5 minutes (default: 30 seconds)
  project.scheduler.polling_interval = 5.minutes

end