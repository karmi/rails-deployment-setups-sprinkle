package :tools do
  description "Various tools needed by the application"

  packages = %w[ vim screen curl imagemagick ntp ]

  post :install, 'ntpdate ntp.ubuntu.com'

  apt packages
end
