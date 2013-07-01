class HacksController < ApplicationController

  before_filter :get_hack, :only => [:upvote, :downvote, :show, :add_contribution]

  def new
  end

  def create
    hack = Hack.create(params[:hack])
    hack.update_attribute(:requested_hackers, params[:requested_hackers] || 1)
    if hack.errors.any?
      error_message = ""
      error_message += "Please include a title. " if hack.errors.messages[:title]
      error_message += "Please include a description." if hack.errors.messages[:description]
      flash[:error] = error_message
      redirect_to new_hack_path
    else
      flash[:message] = "#{hack.title} has been created and added to the list."
      Activity.create(:user_id => current_user.id, :hack_id => hack.id, :action => 'create')
      return redirect_to root_path
    end
  end

  def index
    @hacks = Hack.order("votes DESC").paginate(:page => params[:page] || 1, :per_page => 10)
    @activities = Activity.order("created_at DESC").limit(20)
  end

  def show
  end

  def upvote
    unless current_user
      flash[:error] = "You have to sign in before you can vote you dumbass."
      return redirect_to hack_path(@hack)
    end

    if current_user.bankroll <= 0
      flash[:error] = "no more votes left to give!"
    elsif @hack.contributions.detect { |c| c.user_id == current_user.id }
      flash[:error] = "Trying to upvote our own hack are we? Sorry can't do!"
      return redirect_to :back
    else
      @hack.upvote(current_user)
      flash[:message] = "you have cast your vote!"
    end
    redirect_to :back
  end

  def downvote
    unless current_user
      flash[:error] = "You have to sign in before you can vote you dumbass!"
      return redirect_to hack_path(@hack)
    end

    if current_user.bankroll <= 0
      flash[:error]   = "no more votes left to give!"
    else
      @hack.downvote(current_user)
      flash[:message] = "You just voted down someone's hard work. You are a terrible person!"
    end
    redirect_to :back
  end

  def add_contribution
    unless current_user
      flash[:error] = "You have to sign in before you can claim a hack you dumbass"
      return redirect_to hack_path(@hack)
    end

    if @hack.has_contribution?(current_user)
      flash[:error] = "You're already a contributor!"
    else
      @hack.add_contribution(current_user)
      flash[:message] = "We recognize you for your efforts, thank you for your service."
    end
    redirect_to hack_path(@hack)
  end

  def remove_contribution
    if !@hack.has_contribution?(current_user)
      flash[:error] = "what are you doing? you aren't a contributor!"
    else
      @hack.remove_contribution(current_user)
      flash[:message] = "you are no longer a contributor :("
    end
    redirect_to hack_path(@hack)
  end

  private

  def get_hack
    @hack = Hack.find(params[:id])
  end

end
