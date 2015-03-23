# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative 'lib/util'
require_relative 'lib/env_config'

SERVER_ENV = File.read '.env'

VAGRANT_PATH = Dir.pwd

config_file = File.join(VAGRANT_PATH, 'config', Util.append_extension(SERVER_ENV,'yml'))

EnvConfig::Handler.load_config(config_file)

Vagrant.require_version '>= 1.5.1'

Vagrant.configure("2") do |config|
  config.vm.box = 'ubuntu/trusty64'
  
  config.vm.network :private_network, ip: EnvConfig::Handler.config['vagrant']['ip']
  
  config.vm.hostname = EnvConfig::Handler.config['vagrant']['hostname']

  Dir.glob('scripts/*.sh').each do |script_file|
    begin 
      require_relative Util.remove_ext(script_file)
    rescue LoadError
      #do nothing, there are cases where args formatter might not be needed for a script
    end
    
    script_name = Util.strip_name(script_file)
    script_config = EnvConfig::Handler.config[script_name]
    
    if !script_config.nil?
      script_args_arr = EnvConfig::Handler.args_formatters[script_name].call(script_config)
      script_args_arr.each do |script_args|
        config.vm.provision "shell", path: script_file, args: script_args
      end
    else
      config.vm.provision "shell", path: script_file
    end
  end
  
  config.vm.provider 'virtualbox' do |vb|
    # Give VM access to all cpu cores on the host
    cpus = case RbConfig::CONFIG['host_os']
      when /darwin/ then `sysctl -n hw.ncpu`.to_i
      when /linux/ then `nproc`.to_i
      else 2
    end

    # Customize memory in MB
    vb.customize ['modifyvm', :id, '--memory', 1024]
    vb.customize ['modifyvm', :id, '--cpus', cpus]

    # Fix for slow external network connections
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
  end
end