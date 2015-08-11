#---
# Excerpted from "Metaprogramming Ruby: Program Like the Ruby Pros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr for more book information.
#---
# A collection of compatibility scripts, to ease the transition between
# Capistrano 1.x and Capistrano 2.x.

# Depends on the deployment system
load 'deploy'

map = { "update"   => "deploy:update",
        "restart"  => "deploy:restart",
        "cleanup"  => "deploy:cleanup",
        # ...
        "diff_from_last_deploy"  => "deploy:pending:diff",
        "update_code"            => "deploy:update_code",
        "symlink"                => "deploy:symlink",
        "rollback"               => "deploy:rollback",
        "disable_web"            => "deploy:web:disable",
        "enable_web"             => "deploy:web:enable",
        "cold_deploy"            => "deploy:cold",
        "deploy_with_migrations" => "deploy:migrations"
}
 
map.each do |old, new|
  desc "DEPRECATED: See #{new}."
  # ...
  eval "task(#{old.inspect}) do
    warn \"[DEPRECATED] `#{old}' is deprecated. Use `#{new}' instead.\"
    find_and_execute_task(#{new.inspect})
  end"
end

desc "DEPRECATED: See deploy:start."
task :spinner do
  warn "[DEPRECATED] `spinner' is deprecated. Use `deploy:start' instead."
  set :runner, fetch(:spinner_user, "app")
  deploy.start
end