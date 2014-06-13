class UsersController < ApplicationController

  def show
    @user = User.find params[:id]
  end

  def index
    @search = User.search do
      fulltext params[:search]
      order_by(:name, :desc)
    end
    @users = @search.results
end
end