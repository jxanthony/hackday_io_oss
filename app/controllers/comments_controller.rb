class CommentsController < ApplicationController

  before_filter :find_hack_and_user, :only => [:create]
  
  def create
    @hack.comments.create(:user_id => @user.id, :body => params[:comment][:body])
    Activity.create(:user_id => @user.id, :hack_id => @hack.id, :action => 'comment')
    redirect_to hack_path(@hack)
  end

  private

  def find_hack_and_user
    @hack = Hack.find_by_id params[:hack_id]
    @user = current_user
    unless @hack and @user
      flash[:error] = "no hack found or no user found!"
      redirect_to hack_path(@hack)
    end
  end

end