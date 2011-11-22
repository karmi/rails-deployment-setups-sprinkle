package :ruby_apt do
  description 'Ruby Virtual Machine'
  version '1.9.1'
  patchlevel '378'

  requires :ruby_dependencies

  apt 'ruby1.9.1 ruby1.9.1-dev' do
    post :install, "ln -nfs /usr/bin/ruby1.9.1 /usr/local/bin/ruby"
  end
  
  verify { has_executable_with_version "/usr/local/bin/ruby", version }
end

package :ruby_dependencies do
  description 'Ruby Virtual Machine Build Dependencies'
  apt %w( bison zlib1g-dev libssl-dev libreadline5-dev libncurses5-dev libyaml-0-2 file )
end
