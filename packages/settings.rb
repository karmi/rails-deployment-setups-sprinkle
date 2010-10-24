package :settings do
  noop do
    pre :install, "echo '' > ~/.vimrc"
  end

  transfer 'configurations/vimrc', '~/.vimrc'

  verify do
    has_file '~/.vimrc'
  end
end
