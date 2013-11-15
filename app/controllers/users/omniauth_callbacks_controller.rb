class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :ensure_login
  
	def google_oauth2
	    # You need to implement the method below in your model (e.g. app/models/user.rb)
	    @user = User.find_or_build_for_google_userinfo(
	     request.env["omniauth.auth"][:info])
	    credentials = request.env["omniauth.auth"][:credentials]
	    @user.google_auth_token = credentials[:token]
	    @user.google_auth_refresh_token = credentials[:refresh_token]
	    @user.google_auth_expires_at = Time.at(credentials[:expires_at])
	    @user.remember_me = true	    
	    @user.save	   

	    if @user.persisted?
	      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
	      sign_in_and_redirect @user, :event => :authentication
	    else
	      session["devise.google_data"] = request.env["omniauth.auth"]
	      redirect_to new_user_registration_url
	    end
	end
end