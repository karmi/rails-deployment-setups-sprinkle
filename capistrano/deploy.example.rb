# Example Capistrano configuration file
# =====================================
#
# In real world, use different SCM than "none".

set :application, "demo"

role :web, ENV['DEMO_DEPLOY_HOSTNAME']
role :app, ENV['DEMO_DEPLOY_HOSTNAME']
role :db,  ENV['DEMO_DEPLOY_HOSTNAME'], :primary => true

set :scm, :none
set :repository,  "."
set :deploy_via, :copy
set :deploy_to, "/var/applications/#{application}"
set :user, ENV['DEMO_DEPLOY_USERNAME'] || "deployer"
set :use_sudo, false
set :keep_releases, 3
default_run_options[:pty] = true

# -   Authenticate with key pair, not password
# ssh_options[:keys] = [ File.dirname('/path/to/your/private/key') ]

after "deploy:update_code" do
  run "cd #{release_path} && #{sudo} bundle install --no-color && rake db:migrate RAILS_ENV=production"
  run "ln -nfs #{shared_path}/production.sqlite3  #{release_path}/db/production.sqlite3"
end

namespace :deploy do
  task :stop,  :roles => :app do; end
  task :start, :roles => :app do; end
  task :restart, :roles => :app do
    run "cd #{current_path} && touch tmp/restart.txt"
  end
end

namespace :tail do
  desc "Tail production.log"
  task :default do
    run "tail -n 100 #{deploy_to}/current/log/production.log"
  end
end
