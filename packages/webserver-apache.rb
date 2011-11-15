package :apache, :provides => :webserver do
  requires :build_essential, :apache_dependencies
  description 'Apache 2 HTTP Server'

  apt 'apache2 apache2-mpm-prefork apache2-prefork-dev apache2-utils' do
    post :install, 'a2enmod rewrite', 'a2enmod proxy_http', 'a2enmod proxy_connect', 'a2enmod proxy_balancer', 'a2enmod expires', 'a2enmod headers'
  end

  post :install, '/etc/init.d/apache2 start'

  verify do
    has_executable '/usr/sbin/apache2'
    has_executable '/etc/init.d/apache2'
    # Check enabled mods
    has_file '/etc/apache2/mods-enabled/rewrite.load'
    has_file '/etc/apache2/mods-enabled/proxy_http.load'
    has_file '/etc/apache2/mods-enabled/proxy_connect.load'
    has_file '/etc/apache2/mods-enabled/proxy_balancer.load'
    has_file '/etc/apache2/mods-enabled/expires.load'
    has_file '/etc/apache2/mods-enabled/headers.load'
  end

  optional :apache_etag_support, :apache_deflate_support, :apache_expires_support
end

package :apache_source, :provides => :webserver do
  requires :build_essential, :apache_dependencies
  description 'Apache 2 HTTP Server'
  version '2.2.21'

  source "http://www.apache.org/dist/httpd/httpd-#{version}.tar.bz2" do
    enable %w( mods-shared=all proxy proxy-balancer proxy-http rewrite cache headers ssl deflate so )
    prefix "/opt/local/apache2"
    post :install, 'install -m 755 support/apachectl /etc/init.d/apache2', 'update-rc.d -f apache2 defaults'
    post :install, '/etc/init.d/apache2 start'
  end

  verify do
    has_executable '/etc/init.d/apache2'
  end
end

package :apache_dependencies do
  description 'Apache 2 HTTP Server Build Dependencies'
  apt %w( openssl libtool mawk zlib1g-dev libssl-dev libcurl4-openssl-dev libapr1-dev libaprutil1-dev libexpat1 ssl-cert )

  # TODO: Verify Apache dependencies
end

package :apache_etag_support do
  apache_conf = '/etc/apache2/apache2.conf'
  push_text <<-'CONFIG', apache_conf, :sudo => true

FileETag MTime Size
  CONFIG

  verify { file_contains apache_conf, "FileETag"}
end

package :apache_deflate_support do
  apache_conf = '/etc/apache2/apache2.conf'
  push_text <<-'CONFIG', apache_conf, :sudo => true

<IfModule mod_deflate.c>
  AddOutputFilterByType DEFLATE text/css text/html text/javascript application/javascript application/x-javascript text/js text/plain text/xml
  <IfModule mod_headers.c>
    Header append Vary User-Agent
  </IfModule>
</IfModule>
  CONFIG

  verify { file_contains apache_conf, "DEFLATE"}
end

package :apache_expires_support do
  apache_conf = '/etc/apache2/apache2.conf'
  push_text <<-'CONFIG', apache_conf, :sudo => true
<IfModule mod_expires.c>
  <FilesMatch "\.(ico|css|js|gif|jpe?g|png)\?[0-9]+$">
       ExpiresActive On
       ExpiresDefault "access plus 1 year"
   </FilesMatch>
</IfModule>
  CONFIG

  verify { file_contains apache_conf, "ExpiresActive"}
end
