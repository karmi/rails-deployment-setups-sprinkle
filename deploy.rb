# Pass the server IP on the command line or change this line to suit your configuration
#
hostname = ARGV.pop || '172.16.57.130'

puts "\e[1mRunning installation on host #{hostname}\n\e[0m"

# SSH connection configuration
set  :user, 'karmi'
# set  :user, 'root'
# set  :use_sudo, false
# set  :run_method, :run

default_run_options[:pty] = true

# Application configuration
role :app,  hostname, :primary => true
