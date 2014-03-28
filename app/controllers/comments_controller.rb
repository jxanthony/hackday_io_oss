class CommentsController < ApplicationController
  
  before_filter :check_signed_in

  def create
    # FIXME: this is gross
    hack = Hack.find(params[:hack_id])
    if params[:comment][:private] == "1" and hack.hackday.has_admin?(current_user)
      is_private = true 
    else
      is_private = false
    end
    new_comment = hack.comments.create(user_id: current_user.id, 
                                       body: params[:comment][:body], 
                                       private: is_private)

    if new_comment.errors.any?
      flash[:error] = "Body can't be blank yo!" if new_comment.errors.messages[:body]
      return redirect_to :back
    else
      return redirect_to hack_path(hack)
    end
  end

end