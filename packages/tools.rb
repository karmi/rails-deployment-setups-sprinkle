package :tools do
  description "Common tools needed by applications or for operations"

  packages = %w[ vim screen curl imagemagick ntp ]

  apt packages do
    pre  :install, 'apt-get update'
    post :install, 'ntpdate ntp.ubuntu.com'
  end
end
