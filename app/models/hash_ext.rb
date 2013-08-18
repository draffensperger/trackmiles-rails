class Hash
  def underscore_keys_recursive
    HashExtHelper.underscore_keys_recursive(self)
  end
end

class HashExtHelper
  def self.underscore_keys_recursive(obj)
    if obj.is_a?(Hash)      
      out = {}
      obj.each do |k, v|
        out[k.to_s.underscore.to_sym] = underscore_keys_recursive v
      end
      out
    elsif obj.is_a?(Array)
      out = []
      obj.each do |v|
        out.push underscore_keys_recursive v
      end
      out
    else
      obj
    end
  end  
end