module EmailRegexpValidator
  #http://stackoverflow.com/questions/201323/using-a-regular-expression-to-validate-an-email-address
  def valid_email?(email)   
    !/^.+@.+\..+$/.match(email).nil?    
  end  
  
  module_function :valid_email?
end