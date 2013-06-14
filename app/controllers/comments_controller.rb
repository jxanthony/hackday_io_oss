class CommentsController < ApplicationController

  before_filter :find_hack, :only => [:create]
  
  def create
    @hack.comments.create(:user_id => current_user.id, :body => params[:comment][:body])
    Activity.create(:user_id => current_user.id, :hack_id => @hack.id, :action => 'comment')
    redirect_to hack_path(@hack)
  end

  private

  def find_hack
    @hack = Hack.find_by_id params[:hack_id]
    unless @hack
      flash[:error] = "no hack found!"
      redirect_to root_path
    end
  end

end