begin
  Util
rescue
  require_relative '../../lib/util.rb'
end

trigger_hash = {
  :env => 'development',
  :trigger => {
    :destroy => "Thanks for using VagrantEasy!"
  },
  :trigger_call => Proc.new{|config, command, trigger|
    config.trigger.after command, :stdout => true do
      info "Executing #{command} action on the VirtualBox tied VM..."
      info trigger
    end
  }
}

TriggerConfig::Handler.reg_trigger trigger_hash