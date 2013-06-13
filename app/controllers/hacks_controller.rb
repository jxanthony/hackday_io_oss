class HacksController < ApplicationController

  before_filter :get_hack, :only => [:upvote, :downvote, :show]

  def index
    @hacks = Hack.order("votes DESC")
  end

  def show
  end

  def upvote
    @hack.upvote(current_user)

    redirect_to :back
  end

  def downvote
    @hack.downvote(current_user)

    redirect_to :back
  end

  private

  def get_hack
    @hack = Hack.find(params[:id])
  end

end
