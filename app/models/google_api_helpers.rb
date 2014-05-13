module GoogleApiHelpers
  def get_and_parse(url, params)
    parse_result RestClient.get url, :params => params
  end
  module_function :get_and_parse
  
  def post_and_parse(url, params)
    parse_result RestClient.post url, params
  end
  module_function :post_and_parse
  
  def parse_result(result)
    underscore_keys_recursive JSON.parse result
  end
  module_function :parse_result
  
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
  module_function :underscore_keys_recursive
end