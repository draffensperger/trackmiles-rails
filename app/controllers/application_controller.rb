class ApplicationController < ActionController::Base
  force_ssl(if: :ssl_configured?)
  protect_from_forgery
  before_filter :ensure_login

  def ensure_login
    redirect_to root_path unless current_user
  end

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end

  def after_sign_in_path_for(_resource_or_scope)
    trips_path
  end

  def ssl_configured?
    request.get? && !Rails.env.development? && !Rails.env.test?
  end
end
