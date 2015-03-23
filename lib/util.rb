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
  
end