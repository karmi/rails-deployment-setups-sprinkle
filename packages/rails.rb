package :rails do
  requires :rubygems
  description 'Ruby on Rails'
  version '3.0.1'

  applications_directory = '/var/applications/'

  gem 'rails' do
    post :install, "mkdir -p #{applications_directory}"
    # TODO: Rethink the permissions issue, probably use a 'deployer' user, etc
    # post :install, "chown -R karmi:admin #{applications_directory}"
  end

  verify do
    has_executable 'rails'
    has_gem        "rails", version
    has_directory  applications_directory
  end
end
