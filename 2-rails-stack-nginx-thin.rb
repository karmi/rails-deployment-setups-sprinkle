require File.expand_path('../helper', __FILE__)

# Start the application with:
#
#     $ cd /var/applications/demo && bundle exec thin --socket /tmp/thin.sock --server 3 --environment production --tag demoapp --rackup config.ru start
#
#

policy :rails_stack_nginx_thin, :roles => :app do
  requires :tools
  requires :settings

  requires :ruby

  requires :nginx

  requires :thin
  requires :thin_configuration
  requires :nginx_configuration

  requires :rails

  requires :sqlite

  requires :version_control
end

deployment do

  delivery :capistrano do
    recipes ENV['RECIPE'] || 'deploy'
  end

  source do
    prefix   '/usr/local'           # where all source packages will be configured to install
    archives '/usr/local/sources'   # where all source packages will be downloaded to
    builds   '/usr/local/build'     # where all source packages will be built
  end

end
