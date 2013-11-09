module GoogleApiHelpers
  def get_and_parse(url, params)
    parse_result RestClient.get url, :params => params
  end
  
  def post_and_parse(url, params)
    parse_result RestClient.post url, params
  end
  
  def parse_result(result)
    underscore_keys_recursive JSON.parse result
  end
  
  def underscore_keys_recursive(obj)
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