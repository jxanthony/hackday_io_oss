# == Schema Information
#
# Table name: hacks
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  score       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Hack < ActiveRecord::Base
  attr_accessible :description, :score, :title, :votes, :upvoted_by, :downvoted_by

  serialize :upvoted_by
  serialize :downvoted_by

  has_many :comments
  has_many :contributions
  has_many :activities

  belongs_to :creator, :class_name => 'User', :foreign_key => "creator_id"

  validates_presence_of :title, :description

  def upvote(user)
    #self.votes += 1
    #user.bankroll -= 1

    self.upvoted_by << user.id unless self.upvoted_by.include? user.id
    self.votes = self.upvoted_by.size - self.downvoted_by.size

    self.save
    #user.save

   # YAMMER.create_message("#{user.name} has voted for #{self.title}", :group_id => 2032538)

    #Activity.create(:user_id => user.id, :hack_id => self.id, :action => 'upvote')
  end

  def downvote(user)
    #self.votes -= 1
    #user.bankroll -= 1

    self.downvoted_by << user.id unless self.downvoted_by.include? user.id
    self.votes = self.upvoted_by.size - self.downvoted_by.size
    
    self.save
    #user.save

   # YAMMER.create_message("#{user.name} has DOWNVOTED for #{self.title}", :group_id => 2032538)

    #Activity.create(:user_id => user.id, :hack_id => self.id, :action => 'downvote')
  end

  def has_contribution?(user)
    self.contributions.detect { |contribution| contribution.user_id == user.id }
  end

  def add_contribution(user)
    Contribution.create(:user_id => user.id, :hack_id => self.id)
    Activity.create(:user_id => user.id, :hack_id => self.id, :action => 'add_contribution')
  end

  def remove_contribution(user)
    self.contributions.detect { |contribution| contribution.user_id == user.id }.destroy
    Activity.create(:user_id => user.id, :hack_id => self.id, :action => 'remove_contribution')
  end

end
