class HacksController < ApplicationController

  before_filter :get_hack, :only => [:upvote, :downvote, :show]

  def index
    @hacks = Hack.order("votes DESC")
  end

  def show
  end

  def upvote
    if current_user.bankroll <= 0
      flash[:error] = "no more votes left to give!"
    else
      flash[:message] = "you have cast your vote!"
      @hack.upvote(current_user)
    end
    redirect_to :back
  end

  def downvote
    if current_user.bankroll <= 0
      flash[:error]   = "no more votes left to give!"
    else
      flash[:message] = "you are a terrible person"
      @hack.downvote(current_user)
    end
    redirect_to :back
  end

  private

  def get_hack
    @hack = Hack.find(params[:id])
  end

end
