# == Schema Information
#
# Table name: hackdays
#
#  id                       :integer          not null, primary key
#  title                    :string(255)
#  date                     :date
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  presentation_in_progress :boolean
#

require 'spec_helper'

describe Hackday do

  it "has a valid fabricator" do
    Fabricate(:hackday).should be_valid
  end

  it "requires a title"
  it "requires a date"

  describe "queue behavior" do

    before(:each) do
      @hackday = Fabricate(:hackday)
      @hack = Fabricate(:hack, hackday: @hackday)
      @hack2 = Fabricate(:hack, hackday: @hackday)
    end

    it "enqueues hacks properly" do
      @hackday.join_queue(@hack)
      @hackday.join_queue(@hack2)

      @hack.presentation_index.should == 1
      @hack2.presentation_index.should == 2
      @hackday.queue.should == [@hack, @hack2]
    end

    it "dequeues hacks properly" do
      @hackday.join_queue(@hack)
      @hackday.join_queue(@hack2)
      @hackday.leave_queue(@hack)

      @hack.presentation_index.should == nil
      @hack2.reload.presentation_index.should == 1 # FIXME: not sure why this needs reloading
      @hackday.queue.should == [@hack2]
    end

    it "moves hacks up in the queue properly" do
      @hackday.join_queue(@hack)
      @hackday.join_queue(@hack2)
      @hackday.move_up_in_queue(@hack2)

      @hackday.queue.should == [@hack2, @hack]
    end

    it "moves hacks down in the queue properly" do
      @hackday.join_queue(@hack)
      @hackday.join_queue(@hack2)
      @hackday.move_down_in_queue(@hack)

      @hackday.queue.should == [@hack2, @hack]
    end

    it "should handle moving hacks at the top and bottom of the queue properly" do
      @hackday.join_queue(@hack)
      @hackday.join_queue(@hack2)

      @hackday.move_up_in_queue(@hack).should == false
      @hackday.move_down_in_queue(@hack2).should == false
    end

  end

  describe 'admin management' do
    describe '.add_admin' do
      it 'adds new admin' do
        user    = Fabricate(:user)
        hackday = Fabricate(:hackday)

        hackday.add_admin(user)

        expect(hackday.admins).to eq [user]
      end

      it "doesn't add an admin if already an admin" do
        user    = Fabricate(:user)
        hackday = Fabricate(:hackday, admins: [user])

        hackday.add_admin(user)

        expect(hackday.admins).to eq [user]
      end
    end

    describe '.add_admins' do
      it 'adds many new admins' do
        user1   = Fabricate(:user)
        user2   = Fabricate(:user)
        hackday = Fabricate(:hackday)

        hackday.add_admins([user1, user2])

        expect(hackday.admins.sort).to eq [user1, user2]
      end
    end

    describe '.delete_admin' do
      it 'deletes existing admin' do
        user = Fabricate(:user)
        hackday = Fabricate(:hackday, admins: [user])

        hackday.delete_admin(user)

        expect(hackday.admins).to eq []
      end
    end
  end
end
