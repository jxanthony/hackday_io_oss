class ActivitiesController < ApplicationController
  def index
    if params[:hack_id]
      scope = Hack.find(params[:hack_id])
    elsif params[:hackday_id]
      scope = Hackday.find(params[:hackday_id])
    end

    render scope.activities.where("activities.id > #{params[:cursor] || 0}").order("created_at DESC").limit(12).reverse!
  end
end