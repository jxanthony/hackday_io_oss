class HacksController < ApplicationController

  before_filter :get_hack, :only => [:upvote, :downvote, :show, :edit, :update, :destroy, :add_contribution, 
    :remove_contribution, :move_up_in_queue, :move_down_in_queue, :join_presentation, :leave_presentation]
  before_filter :can_move_hacks_in_queue, :only => [:move_up_in_queue, :move_down_in_queue]
  before_filter :verify_participation, :only => [:join_presentation, :leave_presentation]
  before_filter :check_permission, :only => [:edit, :update, :destroy]

  def new
  end

  def create
    hack = Hack.create(params[:hack])
    hack.update_attributes({:requested_hackers => params[:requested_hackers] || 1})
    hack.update_attributes({:creator_id => current_user.id})
    if hack.errors.any?
      flash[:error] = hack.errors.full_messages.join(", ")
      redirect_to new_hack_path
    else
      flash[:message] = "#{hack.title} has been created. You are group number #{hack.group_number}, please get this number tag from the organizers."
      Activity.create(:user_id => current_user.id, :hack_id => hack.id, :action => 'create')
      return redirect_to root_path
    end
  end

  def index
    @view = params[:view] || 'top'
    if @view == 'top'
      @hacks = Hack.order("votes DESC").paginate(:page => params[:hacks_page] || 1, :per_page => 10)
    elsif @view == 'presentation'
      @hacks = Hack.where("presentation_index IS NOT NULL").order("presentation_index ASC").paginate(:page => params[:hacks_page] || 1, :per_page => 10)
    end
  end

  def show
    @hack_comments = @hack.comments.where(:admin_comment => nil).order('created_at DESC').paginate(:page => params[:hack_comments_page] || 1, :per_page => 10)
    @hack_admin_comments = @hack.comments.where(:admin_comment => true).order('created_at DESC').paginate(:page => params[:hack_admin_comments_page] || 1, :per_page => 8)
  end

  def edit
  end

  def update
    @hack.update_attributes(params[:hack])
    if @hack.errors.any?
      flash[:error] = @hack.errors.full_messages.join(", ")
      redirect_to edit_hack_path(@hack)
    else
      flash[:message] = "Update successful!"
      Activity.create(:user_id => current_user.id, :hack_id => @hack.id, :action => 'edit')
      redirect_to hack_path(@hack)
    end
  end

  def destroy
    if @hack.destroy
      flash[:message] = "Your hack has been destroyed. Please return your group number tag #{@hack.group_number} to the organizers."
      redirect_to root_path
    else
      flash[:error] = @hack.errors.full_messages.join(", ")
    end
  end

  def upvote
    unless current_user
      flash[:error] = "You have to sign in before you can vote you dumbass."
      return redirect_to hack_path(@hack)
    end

    if @hack.upvoted_by.include? current_user.id
      @hack.upvote(current_user)
      flash[:message] = "You have removed your vote."
    else
      @hack.upvote(current_user)
      flash[:message] = "You have cast your vote!"
    end
    redirect_to :back
  end

  def downvote
    unless current_user
      flash[:error] = "You have to sign in before you can vote you dumbass!"
      return redirect_to hack_path(@hack)
    end

    if @hack.downvoted_by.include? current_user.id
      @hack.downvote(current_user)
      flash[:message] = "You have removed your vote."
    else
      @hack.downvote(current_user)
      flash[:message] = "You just voted down someone's hard work. You are a terrible person!"
    end
    redirect_to :back
  end

  def add_contribution
    unless current_user
      flash[:error] = "You have to sign in before you can claim a hack you dumbass"
      return redirect_to hack_path(@hack)
    end

    if @hack.has_contribution?(current_user)
      flash[:error] = "You're already a contributor!"
    else
      @hack.add_contribution(current_user)
      flash[:message] = "We recognize you for your efforts, thank you for your service."
    end
    redirect_to :back
  end

  def remove_contribution
    if !@hack.has_contribution?(current_user)
      flash[:error] = "what are you doing? you aren't a contributor!"
    else
      @hack.remove_contribution(current_user)
      flash[:message] = "you are no longer a contributor :("
    end
    redirect_to :back
  end

  def move_up_in_queue
    unless @hack.presentation_index == 1
      swap_target = Hack.where(:presentation_index => @hack.presentation_index - 1).first
      swap_target.update_attribute(:presentation_index, @hack.presentation_index) if swap_target
      @hack.update_attribute(:presentation_index, @hack.presentation_index - 1)
      Activity.create(:user_id => current_user.id, :hack_id => @hack.id, :action => 'move_up_in_queue')
      flash[:message] = "Your hack has been moved up in the presentation queue."
    else
      flash[:error] = "Your hack is already at the top of the queue."
    end
    redirect_to :back
  end

  def move_down_in_queue
    unless @hack.presentation_index + 1 > Hack.where("hacks.presentation_index IS NOT NULL").size
      swap_target = Hack.where(:presentation_index => @hack.presentation_index + 1).first
      swap_target.update_attribute(:presentation_index, @hack.presentation_index) if swap_target
      @hack.update_attribute(:presentation_index, @hack.presentation_index + 1)
      Activity.create(:user_id => current_user.id, :hack_id => @hack.id, :action => 'move_down_in_queue')
      flash[:message] = "Your hack has been moved down in the presentation queue."
    else
      flash[:error] = "Your hack is already the last one in the queue."
    end
    redirect_to :back
  end

  def join_presentation
    new_index = Hack.where("hacks.presentation_index IS NOT NULL").size + 1
    @hack.update_attribute(:presentation_index, new_index)
    Activity.create(:user_id => current_user.id, :hack_id => @hack.id, :action => 'join_presentation')
    flash[:message] = "Woohoo! Let's show the judges your hard work!"
    redirect_to hacks_path(:view => :presentation)
  end

  def leave_presentation
    @hack.update_attribute(:presentation_index, nil)
    Activity.create(:user_id => current_user.id, :hack_id => @hack.id, :action => 'leave_presentation') unless params[:no_activity]
    reorder_presentation_queue
    flash[:message] = "You are no longer presenting your hack." unless params[:no_activity]
    redirect_to :back
  end

  private

  def can_move_hacks_in_queue
    current_user.mc?
  end

  def check_permission
    unless current_user && current_user == @hack.creator
      flash[:error] = "You don't have permission to perform this action."
      return redirect_to root_path
    end
  end

  def get_hack
    @hack = Hack.find(params[:id])
  end

  def reorder_presentation_queue
    hacks = Hack.where("hacks.presentation_index IS NOT NULL").order("presentation_index ASC")
    hacks.each_with_index do |hack, index|
      hack.update_attribute(:presentation_index, index + 1)
    end
  end

  def verify_participation
    unless current_user.admin? || current_user.mc? || (@hack.creator == current_user) || @hack.contributions.detect {|c| c.user.id == current_user.id}
      flash[:error] = "What are you doing? That's not your hack!"
      return redirect_to :back
    end
  end

end
