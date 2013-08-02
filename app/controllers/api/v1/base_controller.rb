class Api::V1::BaseController < ApplicationController
  def ensure_login
    token = params(:google_token)
    current_user = User.get_userinfo_for_google_token(token)
    unless current_user 
      if token
        nil
      else
        nil
      end
    end
  end
end
