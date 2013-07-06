class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    #session[:user_id] = user.id
    auth = request.env['omniauth.auth']
    render :json => auth.to_json
  end

  def destroy
  	redirect_to root_url
  end
end