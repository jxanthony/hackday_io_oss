# == Schema Information
#
# Table name: activities
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  hack_id    :integer
#  action     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Activity do

  before(:each) do
    @hackday = Fabricate(:hackday)
    @user = Fabricate(:user)
    User.current = @user
    @hack = Fabricate(:hack, hackday: @hackday)
  end

  it "is created when a hack is created" do
    Activity.first.action.should == 'create'
    Activity.first.hack.should == @hack
    Activity.first.user.should == @user
  end

  it "is created when a hack is edited" do
    @hack.title = "updated title"
    @hack.save

    Activity.first.action.should == 'edit'
    Activity.first.hack.should == @hack
    Activity.first.user.should == @user
  end

  it "is created when a hack is up voted" do
    @hack.upvote(@user)

    Activity.first.action.should == 'upvote'
    Activity.first.hack.should == @hack
    Activity.first.user.should == @user
  end

  it "is created when a hack is down voted" do
    @hack.downvote(@user)

    Activity.first.action.should == 'downvote'
    Activity.first.hack.should == @hack
    Activity.first.user.should == @user
  end

  it "is created when a hack is commented on" do
    @hack.comments << Fabricate(:comment, hack: @hack, user: @user)

    Activity.first.action.should == 'comment'
    Activity.first.hack.should == @hack
    Activity.first.user.should == @user
  end

  it "is created when someone joins a hack" do
    @hack.add_contribution(@user)

    Activity.first.action.should == 'add_contribution'
    Activity.first.hack.should == @hack
    Activity.first.user.should == @user
  end

  it "is created when someone leaves a hack" do
    @hack.add_contribution(@user)
    @hack.remove_contribution(@user)

    Activity.first.action.should == 'remove_contribution'
    Activity.first.hack.should == @hack
    Activity.first.user.should == @user
  end

  it "is created when a hack is moved up in the queue" do 
    @hack.update_attribute(:presentation_index, 2)
    @hackday.move_up_in_queue(@hack)

    Activity.first.action.should == 'move_up_in_queue'
    Activity.first.hack.should == @hack
    Activity.first.user.should == @user
  end

  it "is created when a hack is moved down in the queue" do
    @hack.update_attribute(:presentation_index, 1)
    Fabricate(:hack, hackday: @hackday, presentation_index: 2)
    @hackday.move_down_in_queue(@hack)

    Activity.first.action.should == 'move_down_in_queue'
    Activity.first.hack.should == @hack
    Activity.first.user.should == @user
  end

  it "is not created for editing when a hack is voted on" do
    @hack.downvote(@user)

    Activity.where(action: 'edited').should == []
  end


end
