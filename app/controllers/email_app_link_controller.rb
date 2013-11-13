class EmailAppLinkController < ApplicationController  
  include EmailRegexpValidator
      
  def email_android_link
    @email = params[:email]
    
    if valid_email?(@email)
      render json: {success: 'ok'}      
      ActionMailer::Base.mail(
        from: ENV['SERVER_FROM_EMAIL'], 
        to: params[:email], 
        :subject => "test", 
        :body => "test"
      ).deliver
    else
      render status: :bad_request, json: {bad_request: 'Invalid email address',
        email: @email}
    end        
  end
end
