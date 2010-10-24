package :thin, :provides => :appserver do
  requires :build_essential, :rubygems
  description 'Thin Web Server'
  version '1.2.7'

  gem 'thin', :version => version
  
  verify { has_executable '/usr/local/bin/thin' }

  optional :thin_configuration, :nginx_configuration
end

# Run the application server with this command:
#
#   bundle exec thin --socket /tmp/thin.sock --server 3 --environment production --tag demo --rackup config.ru start
#
package :thin_configuration do
  description "Nginx as Reverse Proxy Configuration for Thin"
  configuration_file = '/var/nginx/thin.conf'

  noop do
    pre :install, 'mkdir -p /var/nginx/'
    pre :install, 'rm /etc/nginx/sites-available/default'
  end
  push_text File.read('configurations/thin.conf'), configuration_file, :sudo => true

  verify do
    has_file      configuration_file
    file_contains configuration_file, "thin_cluster"
  end
end

package :nginx_configuration do
  description "Load Thin cluster configuration in Nginx configuration file"
  configuration_file = '/etc/nginx/nginx.conf'

  push_text 'include /var/nginx/thin.conf;', configuration_file, :sudo => true

  verify do
    has_file      configuration_file
    file_contains configuration_file, "include /var/nginx/thin.conf"
  end
end
