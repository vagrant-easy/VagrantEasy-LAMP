begin
  Util
rescue
  require_relative '../../lib/util.rb'
end

EnvConfig::Handler.reg_formatter Util.strip_name(__FILE__) do |config|
  args = []

  config.each do |mysql_dbs_config|
    mysql_dbs_args = []
    
    mysql_dbs_config.each do |key, val|
       mysql_dbs_args << "--#{key}"
       mysql_dbs_args << val
    end
    
    # This script depends on config for mysql_install
    mysql_dbs_args << '--root_pass'
    mysql_dbs_args << EnvConfig::Handler.config['mysql_install']['root_pass']
    
    args << mysql_dbs_args
  end
  
  args
end