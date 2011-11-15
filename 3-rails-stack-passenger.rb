require File.expand_path('../helper', __FILE__)

# The application is started automagically. Restart with:
#
#     $ cd /var/applications/demo && touch tmp/restart.txt
#
#

policy :rails_stack_passenger, :roles => :app do
  requires :tools
  requires :settings

  requires :ruby

  requires :apache

  requires :passenger
  requires :passenger_configuration

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
