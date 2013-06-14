class ApplicationController < ActionController::Base
  protect_from_forgery


  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]

    if Rails.env.development?
    	@current_user = User.first
    end 
  end

  helper_method :current_user

end
