class HacksController < ApplicationController

  def index
    @hacks = Hack.order("score DESC")
  end

  def show
    @hack = Hack.find(params[:id])
  end

  def show
    @hack = Hack.find(params[:id])
  end

  def upvote
    @hack.upvote(current_user)
  end

  def downvote
    @hack.downvote(current_user)
  end

end
