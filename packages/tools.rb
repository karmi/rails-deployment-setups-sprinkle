package :tools do
  description "Common tools needed by applications or for operations"

  packages = %w[ vim screen curl imagemagick ntp ]

  post :install, 'ntpdate ntp.ubuntu.com'

  apt packages
end
