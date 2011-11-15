Vagrant::Config.run do |config|
  config.vm.box       = "ubuntu"
  config.vm.box_url   = "http://files.vagrantup.com/lucid64.box"

  config.vm.customize do |vm|
    vm.memory_size = 512
    vm.name = "ubuntu"
  end

  # Assign this VM to a host only network IP, allowing you to access it via the IP.
  config.vm.network "33.33.33.10"

  # Forward a port from the guest to the host.
  # config.vm.forward_port "http", 80, 8080

  # Share an additional folder to the guest VM.
  config.vm.share_folder 'setup-recipes', 'setup-recipes', File.expand_path('../', __FILE__).to_s
end
