# == Schema Information
#
# Table name: hacks
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  description        :text(255)
#  votes              :integer          default(0)
#  url                :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  requested_hackers  :integer
#  presentation_index :integer
#  creator_id         :integer
#  upvoted_by         :text             default("'--- []\n'")
#  downvoted_by       :text             default("'--- []\n'")
#  group_number       :integer
#  hackday_id         :integer
#

class Hack < ActiveRecord::Base
  attr_accessible :creator_id, :description, :title, :votes, :upvoted_by, :downvoted_by, :group_number, :requested_hackers, :url

  serialize :upvoted_by
  serialize :downvoted_by

  has_many :comments,      :dependent => :destroy
  has_many :contributions, :dependent => :destroy
  has_many :activities,    :dependent => :destroy
  has_many :contributors, through: :contributions, source: :user

  belongs_to :creator, :class_name => 'User', :foreign_key => "creator_id"
  belongs_to :hackday

  validates_presence_of :title, :description

  before_create :set_group_number, :initialize_votes
  before_destroy :free_group_number

  after_create :create_activity

  def upvote(user)
    self.lock!
    if self.upvoted_by.include? user.id
      self.upvoted_by.delete user.id
    else
      self.upvoted_by << user.id
    end

    self.downvoted_by.delete(user.id) if self.downvoted_by.include? user.id
    self.votes = self.upvoted_by.size - self.downvoted_by.size

    self.save!
  end

  def downvote(user)
    self.lock!
    if self.downvoted_by.include? user.id
      self.downvoted_by.delete user.id
    else
      self.downvoted_by << user.id
    end

    self.upvoted_by.delete(user.id) if self.upvoted_by.include? user.id
    self.votes = self.upvoted_by.size - self.downvoted_by.size

    self.save!
  end

  def has_contributor?(user)
    self.contributors.include? user
  end

  def add_contribution(user)
    Contribution.create(:user_id => user.id, :hack_id => self.id)
    Activity.create(:user_id => user.id, :hack_id => self.id, :action => 'add_contribution')
  end

  def remove_contribution(user)
    self.contributions.detect { |contribution| contribution.user_id == user.id }.destroy
    Activity.create(:user_id => user.id, :hack_id => self.id, :action => 'remove_contribution')
  end

  private
  def set_group_number
    if self.hackday.group_numbers.empty?
      self.errors.add(:group_number, "Out of available group numbers. Go yell at Kane.")
      return false
    else
      self.group_number = self.hackday.group_numbers.shift
      self.hackday.save
    end
  end

  def free_group_number
    unless !self.group_number || self.hackday.group_numbers.include?(self.group_number)
      self.hackday.group_numbers.unshift self.group_number
      self.hackday.save
    else
      true
    end
  end

  def initialize_votes
    self.upvoted_by = [] unless self.upvoted_by == []
    self.downvoted_by = [] unless self.downvoted_by == []
  end

  def create_activity
    # FIXME: gross
    activity = Activity.new(action: 'create')
    activity.user = self.contributions.first.user
    activity.hack = self
    activity.save
  end

end
