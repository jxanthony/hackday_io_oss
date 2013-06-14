class HacksController < ApplicationController

  before_filter :get_hack, :only => [:upvote, :downvote, :show, :add_contribution]

  def index
    @hacks = Hack.order("votes DESC")
  end

  def show
  end

  def upvote
    if current_user.bankroll <= 0
      flash[:error] = "no more votes left to give!"
    else
      @hack.upvote(current_user)
      flash[:message] = "you have cast your vote!"
    end
    redirect_to :back
  end

  def downvote
    if current_user.bankroll <= 0
      flash[:error]   = "no more votes left to give!"
    else
      @hack.downvote(current_user)
      flash[:message] = "you are a terrible person"
    end
    redirect_to :back
  end

  def add_contribution
    unless current_user
      flash[:error] = "sign in before you can vote you dumbass"
      return redirect_to hack_path(@hack)
    end

    if @hack.has_contribution?(current_user)
      flash[:error] = "you're already a contributor!"
    else
      @hack.add_contribution(current_user)
      flash[:message] = "we recognize you for your efforts, thank you"
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
