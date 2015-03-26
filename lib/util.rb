module Util
  
  def self.append_extension(subject, ext)
    subject+'.'+ext
  end
  
  def self.remove_ext(file)
    file.gsub(File.extname(file),'')
  end
  
  def self.strip_name(file)
    File.basename(file).gsub(File.extname(file),'').gsub(/^\d{1,}\./,'')
  end
  
  def self.stringify_bools!(target)
    target.replace stringify_bools(target)
  end

  def self.stringify_bools(target)
    t_clone = target.clone
    
    raise ArgumentError, 'Target is neither Array or Hash' unless target.is_a?(Array) || target.is_a?(Hash)
    
    case target.class.to_s
      when 'Array'
        t_clone.map! do |el|
          el = el.to_s if el.is_a?(TrueClass) || el.is_a?(FalseClass)
          el = stringify_bools(el) if el.is_a?(Array) || el.is_a?(Hash)
          
          el
        end
      when 'Hash'
        t_clone.each do |key, val|
          t_clone[key] = val.to_s if val.is_a?(TrueClass) || val.is_a?(FalseClass)
          t_clone[key] = stringify_bools(val) if val.is_a?(Array) || val.is_a?(Hash)
        end
    end
    
    t_clone
  end
  
end