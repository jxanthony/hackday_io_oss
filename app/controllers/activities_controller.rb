class ActivitiesController < ApplicationController
  def index
    results = Activity.order("created_at DESC").limit(10).reverse!

    render :json => results.to_json(:include => [:user, :hack]), :status => :ok
  end
end