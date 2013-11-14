class EmailAppLinkController < ApplicationController  
  include EmailRegexpValidator
      
  def email_android_link
    email = params[:email]
    
    if valid_email? email              
      AppLinkMailer.android_app_link_email(email).deliver
      render json: {status: 'success'}               
    else
      render status: :bad_request, json: {bad_request: 'Invalid email address',
        email: email}
    end        
  end
end
