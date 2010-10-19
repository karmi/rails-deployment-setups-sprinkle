require 'helper'

policy :rails_stack_nginx_thin, :roles => :app do
  requires :ruby

  requires :nginx

  requires :thin
  requires :thin_configuration
  requires :nginx_configuration

  requires :rails

  requires :sqlite

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
