class HacksController < ApplicationController

  def index
    @hacks = Hack.order("score DESC")
  end

  def show
    @hack = Hack.find(params[:id])
  end

end
