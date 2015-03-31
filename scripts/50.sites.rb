begin
  Util
rescue
  require_relative '../lib/util.rb'
end

EnvConfig::Handler.reg_formatter Util.strip_name(__FILE__) do |config|
  args = []
  
  skip = ['site_name','local_path','aliases']
  site_args = []
  
  config.each_with_index do |sites_config, i|
    sites_config.each do |key, val|
      unless skip.include? key
        key = 'site_path' if key == 'remote_path'
        
        site_args << "--#{key}"
        site_args << val
      end
    end
    
    last = (i == config.size - 1)
    site_args << '--last'
    site_args << last.to_s
    
    args << site_args
  end
  
  
  args
end