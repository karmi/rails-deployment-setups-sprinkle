package :settings do
  description "Custom settings"

  push_text File.read('configurations/vimrc'), '~/.vimrc', :sudo => true

  verify do
    has_file '~/.vimrc'
  end
end
