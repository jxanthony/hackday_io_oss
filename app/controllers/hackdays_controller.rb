class HackdaysController < ApplicationController

  before_filter :check_signed_in, only: [:create, :update, :destroy]
  
  def create
    hackday = Hackday.new(params[:hackday])
    hackday.admins << current_user

    if hackday.save
      redirect_to hackday
    else
      flash[:error] = hackday.errors.full_messages.join(", ")
    end
  end

  def update
    hackday = Hackday.find(params[:id])
    hackday.update_attributes(params[:hackday])
    if hackday.errors.any?
      flash[:error] = hackday.errors.full_messages.join(", ")
      redirect_to hackday
    else
      flash[:message] = "Updated your Hack Day"
      redirect_to hackday
    end
  end

  def destroy
    hackday = Hackday.find(params[:id])
    if hackday.destroy
      flash[:message] = "Your Hack Day has been destroyed. This is a sad day."
      redirect_to root_url
    else
      flash[:error] = "There was some kind of problem destroying your Hack Day - perhaps the server couldn't bear the thought of destroying a Hack Day"
    end
  end

  def show
    @hackday = Hackday.find(params[:id])
    @hacks = @hackday.hacks.order("votes DESC")
  end

  def index
    @ongoing_hackdays = Hackday.where('date = ?', Date.today)
    @upcoming_hackdays = Hackday.where('date > ?', Date.today)
    @past_hackdays = Hackday.where('date < ?', Date.today)
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