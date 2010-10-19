# Pass the server IP on the command line or change this line to suit your configuration
#
hostname = ARGV.pop || '172.16.57.130'

puts "\e[1mRunning installation on host #{hostname}\n\e[0m"

set  :user, 'karmi'
role :app,  hostname, :primary => true

default_run_options[:pty] = true
