class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :ensure_login 
  
  def ensure_login
    # fill in later  
  end
end
