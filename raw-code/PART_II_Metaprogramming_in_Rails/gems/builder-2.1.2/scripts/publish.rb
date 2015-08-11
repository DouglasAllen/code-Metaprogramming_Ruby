#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
# Optional publish task for Rake

require 'rake/contrib/sshpublisher'
require 'rake/contrib/rubyforgepublisher'

publisher = Rake::CompositePublisher.new
publisher.add Rake::RubyForgePublisher.new('builder', 'jimweirich')
publisher.add Rake::SshFilePublisher.new(
  'umlcoop',
  'htdocs/software/builder',
  '.',
  'builder.blurb')

desc "Publish the Documentation to RubyForge."
task :publish => [:rdoc] do
  publisher.upload
end
