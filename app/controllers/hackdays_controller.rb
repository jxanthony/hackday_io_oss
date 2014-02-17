class HackdaysController < ApplicationController

  def show
    @hackday = Hackday.find(params[:id])
    @hacks = @hackday.hacks.order("votes DESC")
  end

  def index
    @hackdays = Hackday.all
  end

end