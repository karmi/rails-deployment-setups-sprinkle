require 'helper'

policy :rails_stack, :roles => :app do
  requires :ruby

  requires :appserver
  requires :webserver
  requires :database

  requires :rails

  requires :version_control
  requires :tools
  requires :settings
end

deployment do

  delivery :capistrano do
    recipes 'deploy'
  end

  source do
    prefix   '/usr/local'           # where all source packages will be configured to install
    archives '/usr/local/sources'   # where all source packages will be downloaded to
    builds   '/usr/local/build'     # where all source packages will be built
  end

end
