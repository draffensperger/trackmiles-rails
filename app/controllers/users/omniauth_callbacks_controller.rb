class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :ensure_login
  
	def google_oauth2
	    logger.debug "Starting google_oauth2"
	    @user = User.find_or_build_for_google_userinfo(
	    request.env["omniauth.auth"][:info])
	    credentials = request.env["omniauth.auth"][:credentials]
	    @user.google_auth_token = credentials[:token]
	    @user.google_auth_refresh_token = credentials[:refresh_token]
	    @user.google_auth_expires_at = Time.at(credentials[:expires_at])
	    @user.remember_me = true
	    
	    # I do the sign_in first as it seems to save the record anyway
	    # which 
	    sign_in @user	    
	    @user.save

	    if @user.persisted?
	      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
	      logger.debug "Redirecting from google_oauth2"
	      redirect_to after_sign_in_path_for(@user), :event => :authentication
	    else
	      session["devise.google_data"] = request.env["omniauth.auth"]
	      redirect_to new_user_registration_url
	    end
	end
end