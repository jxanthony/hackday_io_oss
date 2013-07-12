class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :login_required


  private

  def login_required
    unless current_user
      redirect_to welcome_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin_comments
    Comment.where(:admin_comment => true).order('created_at DESC').paginate(:page => params[:admin_comments_page] || 1, :per_page => 7)
    #AdminComment.order("created_at DESC").paginate(:page => params[:admin_comments_page] || 1, :per_page => 8)
  end

  helper_method :current_user
  helper_method :admin_comments

end
