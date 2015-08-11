#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
# set :user, "flippy"
# set :password, "hello-flippy"
# set :gateway, "gateway.example.com"

role :web, "web1.example.com"
role :app, "app1.example.com", "app2.example.com"

desc <<-DESC
This is a sample task. It is only intended to be used as a demonstration of \
how you can define your own tasks.
DESC
task :sample_task, :roles => :app do
  run "ls -l"
end
