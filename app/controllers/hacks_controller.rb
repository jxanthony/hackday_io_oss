class HacksController < ApplicationController
	def index
		@hacks = Hack.order("score DESC")
	end

	def show
		@hack = Hack.find(params[:id])
	end

	def upvote
		# TODO: increment hack score, decrement user score
	end

	def downvote
		# TODO: decrement hack score, increment user bankroll
	end

end
