# Example configuration file for Capistrano Sprinkle deploy strategy
#
#
# -- Application configuration
role :app,  '<CHANGE THIS TO YOUR SERVER IP>', :primary => true

# --- SSH connection configuration
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
# -   Use sudo
# set  :use_sudo, false
#
# -   Declare intareactive terminal
default_run_options[:pty] = true
#
