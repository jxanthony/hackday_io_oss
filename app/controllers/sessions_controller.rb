class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    render :json => auth.to_json
  end

  def destroy
  	redirect_to root_url
  end
end