class CommentsController < ApplicationController
  
  def create
    hack = Hack.find(params[:hack_id])
    unless hack
      flash[:error] = "no hack found!"
      redirect_to root_path
    end

    new_comment = hack.comments.create(user_id: current_user.id, body: params[:comment][:body], admin_comment: params[:admin_comment])

    if new_comment.errors.any?
      error_message = "Body can't be blank yo!" if new_comment.errors.messages[:body]
      error_message = "Can't post a comment without a user!" if new_comment.errors.messages[:user_id]
      error_message = "Uhhh what hack is this comment meant for?" if new_comment.errors.messages[:hack_id]
      flash[:error] = error_message
      return redirect_to :back
    else
      return redirect_to hack_path(hack)
    end
  end

end