module TriggerConfig

  class Handler
    
    @@triggers = []
    
    def self.reg_trigger(trigger)
      @@triggers << trigger
    end
    
    def self.triggers
      @@triggers
    end
    
    def self.triggers_for_env(env)
      env_triggers = @@triggers.reject do |t|
        !is_env?(t, env)
      end
      
      env_triggers
    end
    
    def self.is_env?(trigger, env)
      if trigger[:env].is_a? Array
        trigger[:env].include? env
      elsif trigger[:env].is_a? String
        trigger[:env] = [trigger[:env]]
        is_env?(trigger, env)
      else
       raise 'env property of trigger is expected to be string or array!'
      end
    end
    
  end

end