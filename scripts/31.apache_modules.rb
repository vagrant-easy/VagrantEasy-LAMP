begin
  Util
rescue
  require_relative '../lib/util.rb'
end

EnvConfig::Handler.reg_formatter Util.strip_name(__FILE__) do |config|
  args = []

  config.each do |apache_mod|
    apache_mods_args = []
    
    apache_mods_args << apache_mod
    
    args << apache_mods_args
  end
  
  args
end