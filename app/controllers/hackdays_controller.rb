class HackdaysController < ApplicationController
  
  def show
    @hackday = Hackday.find(params[:id])
    @hacks = @hackday.hacks.order("votes DESC")
  end

  def index
    @upcoming_hackdays = Hackday.where('date > ?', Date.today)
  end

  def queue
    @hackday = Hackday.find(params[:id])
  end

  def judges
    @hackday = Hackday.find(params[:id])

    unless @hackday.has_admin?(current_user)
      flash[:error] = "You're not a judge!"
      return redirect_to :back
    end

    @judges_comments = @hackday.comments.where(private: true).order("created_at DESC")
  end

end