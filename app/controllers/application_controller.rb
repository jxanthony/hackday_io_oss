class ApplicationController < ActionController::Base
  protect_from_forgery

  has_mobile_fu

  before_filter :login_required

  private

  def login_required
    if Rails.env.production? and not current_user
      redirect_to welcome_path
    else
      User.current = current_user
    end
  end

  def current_user
    return User.first if Rails.env.development?
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

end
