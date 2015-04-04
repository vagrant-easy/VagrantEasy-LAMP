begin
  Util
rescue
  require_relative '../../lib/util.rb'
end

EnvConfig::Handler.reg_formatter Util.strip_name(__FILE__) do |config|
  args = []
  
  mysql_install_args = []
  
  config.each do |key, val|
     mysql_install_args << "--#{key}"
     mysql_install_args << val
  end
  
  args << mysql_install_args
  
  args
end