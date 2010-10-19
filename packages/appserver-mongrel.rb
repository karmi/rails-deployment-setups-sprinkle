package :mongrel do
  requires :rubygems
  description 'Mongrel Application Server'
  version '1.2.0.pre2'

  gem 'mongrel', :version => version

  verify { has_gem 'mongrel', '1.2.0.pre2' }

  optional :mongrel_configuration
end

# Run the application server with this command:
#
#   rails server mongrel --environment production
#
package :mongrel_configuration do
  description "Apache as Reverse Proxy Configuration for Mongrel"
  configuration_file = '/etc/apache2/extras/mongrel.conf'

  noop do
    pre  :install, 'mkdir -p /etc/apache2/extras'
  end

  push_text File.read('configurations/mongrel.conf'), configuration_file, :sudo => true

  push_text "Include #{configuration_file}", '/etc/apache2/apache2.conf', :sudo => true

  verify do
    has_file configuration_file
    file_contains configuration_file,          "Mongrel Cluster"
    file_contains '/etc/apache2/apache2.conf', configuration_file
  end
end
