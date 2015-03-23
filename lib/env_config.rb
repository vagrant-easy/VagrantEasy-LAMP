require 'yaml'

module EnvConfig

  class Handler
  
    def self.load_config(config_file)
      raise 'Config file not found.' unless File.exists?(config_file)
      
      @@config = YAML.load_file(config_file)
      @@args_formatters = {}
      
      config
    end
    
    def self.reg_formatter(script_name, &args_f)
      @@args_formatters[script_name] = args_f
    end
    
    def self.config
      @@config
    end
    
    def self.args_formatters
      @@args_formatters
    end
  
  end

end