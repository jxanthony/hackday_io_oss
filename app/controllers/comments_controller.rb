class CommentsController < ApplicationController

  before_filter :find_hack_and_user, :only => [:create]
  
  def create
    @hack.comments.create(:user_id => @user.id, :body => params[:comment][:body])
    redirect_to hack_path(@hack)
  end

  private

  def find_hack_and_user
    @hack = Hack.find_by_id params[:hack_id]
    @user = User.find_by_id params[:user_id]
    unless @hack and @user
      flash[:error] = "no hack found or no user found!"
      redirect_to home_path
    end
  end

end