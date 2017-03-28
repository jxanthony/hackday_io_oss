class HackdaysController < ApplicationController

  before_filter :check_signed_in, only: [:create, :update, :destroy]

  def create
    hackday = Hackday.new(params[:hackday])
    hackday.add_admin(current_user)

    if hackday.save
      redirect_to hackday
    else
      flash[:error] = hackday.errors.full_messages.join(", ")
    end
  end

  def update
    hackday = Hackday.find(params[:id])
    hackday.update_attributes(params[:hackday])
    if hackday.errors.any?
      flash[:error] = hackday.errors.full_messages.join(", ")
      redirect_to hackday
    else
      flash[:message] = "Updated your Hack Day"
      redirect_to hackday
    end
  end

  def destroy
    hackday = Hackday.find(params[:id])
    if hackday.destroy
      flash[:message] = "Your Hack Day has been destroyed. This is a sad day."
      redirect_to root_url
    else
      flash[:error] = "There was some kind of problem destroying your Hack Day - perhaps the server couldn't bear the thought of destroying a Hack Day"
    end
  end

  def show
    @hackday = Hackday.find(params[:id])
    @hacks = @hackday.hacks.order("votes DESC").reject(&:breaktime?)
  end

  def index
    @ongoing_hackdays = Hackday.where('date = ?', Date.today)
    @upcoming_hackdays = Hackday.where('date > ?', Date.today).order("date DESC")
    @past_hackdays = Hackday.where('date < ?', Date.today).order("date DESC")
  end

  def queue
    @hackday = Hackday.find(params[:id])
  end

  def display_queue
    @hackday = Hackday.find(params[:id])
    render layout: false
  end

  def start_presentations
    hackday = Hackday.find(params[:id])
    if hackday.start_presentations
      flash[:message] = "HACK DAY HAS STARTED!!!"
      redirect_to queue_hackday_path(hackday)
    else
      flash[:error] = "Couldn't start Hack Day..."
      redirect_to queue_hackday_path(hackday)
    end
  end

  def end_presentations
    hackday = Hackday.find(params[:id])
    if hackday.end_presentations
      flash[:message] = "Hack Day is over... T_T"
      redirect_to queue_hackday_path(hackday)
    else
      flash[:error] = "Couldn't end Hack Day...FOREVER HACKING?!"
      redirect_to queue_hackday_path(hackday)
    end
  end

  def add_break
    hackday = Hackday.find(params[:id])

    if hackday.add_break(params[:position])
      flash[:message] = 'Break me off a piece of that HACK DAY BAR'
    else
      flash[:error] = 'No breaks for you!'
    end

    redirect_to queue_hackday_path(hackday)
  end

  def remove_break
    breaktime = Hack.find(params[:id])
    hackday = breaktime.hackday

    if hackday.remove_break(breaktime)
      flash[:message] = 'Break is over! Get back to hacking!'
    else
      flash[:error] = 'Can\'t get rid of that break.'
    end

    redirect_to queue_hackday_path(hackday)
  end

  def judges
    @hackday = Hackday.find(params[:id])

    unless @hackday.has_admin?(current_user)
      flash[:error] = "You're not a judge!"
      return redirect_to :back
    end

    @judges_comments = @hackday.comments.where(private: true).order("created_at DESC")
  end

  def add_admins
    hackday = Hackday.find(params[:id])
    admins  = User.find_all_by_id(params[:hackday][:admin_ids].reject(&:empty?))

    if hackday.add_admins(admins)
      flash[:message] = 'User level: JUDGE.'
      redirect_to hackday
    else
      flash[:error] = 'Users not cool enough to be judges.'
      redirect_to hackday
    end
  end

  def delete_admin
    hackday = Hackday.find(params[:id])
    admin   = User.find(params[:admin_id])

    if admin && hackday.delete_admin(admin)
      flash[:message] = 'User no longer has judgemental powers.'
      redirect_to hackday
    else
      flash[:error] = 'User still is a judge...somehow.'
      redirect_to hackday
    end
  end

end