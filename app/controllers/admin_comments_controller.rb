class AdminCommentsController < ApplicationController

  def create
    unless current_user.admin?
      flash[:error] = "You must be an admin to use Judges' Corner!"
      return redirect_to :back
    end
    admin_comment = AdminComment.new(params[:admin_comment])
    admin_comment.user_id = current_user.id
    admin_comment.save

    if admin_comment.errors.any?
      error_message = "Body can't be blank yo!" if admin_comment.errors.messages[:body]
      flash[:error] = error_message
      return redirect_to :back
    else
      flash[:message] = "Totally Unbiased Opinion recorded!"
      return redirect_to :back
    end
  end
end
