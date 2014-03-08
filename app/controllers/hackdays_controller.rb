class HackdaysController < ApplicationController

  has_mobile_fu

  def show
    @hackday = Hackday.find(params[:id])
    @hacks = @hackday.hacks.order("votes DESC")
  end

  def index
    @hackdays = Hackday.all
  end

  def queue
    @hackday = Hackday.find(params[:id])
  end

end