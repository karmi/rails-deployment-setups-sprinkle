package :rubygems do
  requires :ruby
  description 'Ruby Gems Package Management System'
  version '1.3.7'

  source "http://production.cf.rubygems.org/rubygems/rubygems-#{version}.tgz" do
    custom_install 'ruby setup.rb'
  end

  verify { has_executable '/usr/local/bin/gem' }
end
