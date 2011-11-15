package :passenger, :provides => :appserver do
  requires :apache, :rubygems
  description 'Passenger (mod_rails) for Apache'
  version '3.0.9'
  gem 'passenger', :version => version do
    post :install, 'passenger-install-apache2-module --auto'
  end

  verify do
    has_gem  'passenger', version
    has_file "/usr/local/lib/ruby/gems/1.9.1/gems/passenger-#{version}/ext/apache2/mod_passenger.so"
  end

  optional :passenger_configuration
end

# Run the application server with this command:
#
#   touch tmp/restart.txt
#
package :passenger_configuration do
  description "Configure Passenger for Apache"
  configuration_file = '/etc/apache2/extras/passenger.conf'

  push_text File.read('configurations/passenger.conf'), configuration_file, :sudo => true do
    pre :install, 'mkdir -p /etc/apache2/extras'
  end

  push_text "Include #{configuration_file}\n", '/etc/apache2/apache2.conf', :sudo => true do
    post :install, '/etc/init.d/apache2 restart'
  end

  verify do
    has_file      configuration_file
    file_contains configuration_file,          'Passenger Configuration'
    file_contains '/etc/apache2/apache2.conf', configuration_file
  end
end
