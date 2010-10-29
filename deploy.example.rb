# -- Application configuration
role :app,  '<CHANGE THIS TO YOUR SERVER IP>', :primary => true

# --- SSH connection configuration
#
# Regular user
set  :user, '<CHANGE THIS TO YOUR USER>'
#
# Root user
# set  :user, 'root'
# set  :use_sudo, false
# set  :run_method, :run
#
default_run_options[:pty] = true
