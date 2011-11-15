require File.expand_path('../helper', __FILE__)

# Start the application with:
#
#     $ cd /var/applications/demo && bundle exec rails server mongrel --environment production
#
#

policy :rails_stack_apache_mongrel, :roles => :app do
  requires :tools
  requires :settings

  requires :ruby

  requires :apache

  requires :mongrel
  requires :mongrel_configuration

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
