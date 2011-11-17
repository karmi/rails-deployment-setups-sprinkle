# Example configuration file for Capistrano Sprinkle deploy strategy
#
#
# -- Application configuration
#
# Note: The default Vagrant box IP is "33.33.33.10"
#
role :app,  '<CHANGE THIS TO YOUR SERVER IP>', :primary => true

# --- SSH connection configuration
#
# Note: The default Vagrant user is "vagrant"
#
set  :user, '<CHANGE THIS TO YOUR USER>'
#
# --  SSH options
#
# -   Port
# ssh_options[:port] = 22
#
# -   Authenticate with key pair, not password
# ssh_options[:keys] = ['/path/to/your/private/key']
#
# Configuration for the Vagrant box:
#
ssh_options[:keys] = File.join(File.dirname(`gem which vagrant`.strip), '../keys/vagrant')
#
# -   Use sudo
set  :use_sudo, true
#
# -   Declare intareactive terminal
default_run_options[:pty] = true
#
