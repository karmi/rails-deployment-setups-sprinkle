package :ruby do
  description 'Ruby Virtual Machine'
  # We need Ruby 1.9.2 for Passenger, see http://code.google.com/p/phusion-passenger/issues/detail?id=714
  version '1.9.2'
  patchlevel '290'
  source "ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-#{version}-p#{patchlevel}.tar.gz"
  requires :ruby_dependencies
  verify { has_executable_with_version "/usr/local/bin/ruby", version }

  noop { pre :install, 'apt-get purge ruby ruby1.9 ruby1.9.1 rubygems1.8 rubygems1.9 rubygems1.9.1' }
end

package :ruby_dependencies do
  description 'Ruby Virtual Machine Build Dependencies'
  apt %w( bison zlib1g-dev libssl-dev libreadline5-dev libncurses5-dev libyaml-0-2 file )
end
