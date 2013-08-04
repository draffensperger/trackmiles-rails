class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :redirect_to_ssl
  before_filter :ensure_login  
    
  def redirect_to_ssl
    #if Rails.env.production?
      redirect_to :protocol => "https://" unless (request.ssl?)
    #end
  end
  
  def ensure_login
    # fill in later  
  end
end
