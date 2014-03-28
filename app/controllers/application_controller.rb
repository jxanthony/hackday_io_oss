class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_current_user

  private

  def set_current_user
    if current_user
      User.current = current_user
    end
  end

  def current_user
    return User.first if Rails.env.development?
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def is_mobile_device?
    request.user_agent =~ /Mobile|webOS|iPhone/
  end
  helper_method :is_mobile_device?

  def check_signed_in
    unless current_user
      flash[:error] = "You need to be signed in first!"
      return redirect_to :back
    end
  end
  
end
