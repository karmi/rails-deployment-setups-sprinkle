package :git, :provides => :version_control do
  description 'Git Version Control System'

  apt 'git-core'

  verify do
    has_executable 'git'
  end
end
