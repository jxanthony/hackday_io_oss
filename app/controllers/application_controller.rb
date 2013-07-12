class ApplicationController < ActionController::Base
  protect_from_forgery


  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin_comments
    Comment.where(:admin_comment => true).order('created_at DESC').paginate(:page => params[:admin_comments_page] || 1, :per_page => 10)
    #AdminComment.order("created_at DESC").paginate(:page => params[:admin_comments_page] || 1, :per_page => 8)
  end

  helper_method :current_user
  helper_method :admin_comments

end
