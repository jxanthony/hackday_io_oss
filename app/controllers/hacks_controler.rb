class HacksController < ApplicationController
	def index
		@hacks = Hacks.order("score DESC")
	end

	def show
		@hack = Hack.find(params[:id])
	end
end