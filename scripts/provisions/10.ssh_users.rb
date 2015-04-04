begin
  Util
rescue
  require_relative '../../lib/util.rb'
end

EnvConfig::Handler.reg_formatter Util.strip_name(__FILE__) do |config|
  args = []

  config.each do |ssh_user_config|
    ssh_user_args = []
    
    ssh_user_config.each do |key, val|
       ssh_user_args << "--#{key}"
       ssh_user_args << val
    end
    
    args << ssh_user_args
  end
  
  args
end