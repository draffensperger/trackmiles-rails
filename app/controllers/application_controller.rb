class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :ensure_login 

  def ensure_login
    # fill in later  
  end
  
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
  
  def after_sign_in_path_for(resource_or_scope)
    trips_path
  end
end
