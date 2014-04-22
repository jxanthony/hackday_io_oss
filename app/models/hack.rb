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
#  presentation_index :integer
#  upvoted_by         :text             default("'")
#  downvoted_by       :text             default("'")
#  hackday_id         :integer
#

class Hack < ActiveRecord::Base
  attr_accessible :description, :title, :url

  serialize :upvoted_by
  serialize :downvoted_by

  has_many :comments,      :dependent => :destroy
  has_many :contributions, :dependent => :destroy
  has_many :activities,    :dependent => :destroy
  has_many :contributors, through: :contributions, source: :user

  belongs_to :creator, :class_name => 'User', :foreign_key => "creator_id"
  belongs_to :hackday

  validates_presence_of :title, :description

  before_create :initialize_votes

  after_create :activity_for_create
  after_update :activity_for_update

  def upvote(user)
    self.lock!
    if self.upvoted_by.include? user.id
      self.upvoted_by.delete user.id
    else
      self.upvoted_by << user.id
      create_activity('upvote')
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
      create_activity('downvote')
    end

    self.upvoted_by.delete(user.id) if self.upvoted_by.include? user.id
    self.votes = self.upvoted_by.size - self.downvoted_by.size

    self.save!
  end

  def upvoted_by?(user)
    if user
      self.upvoted_by.include? user.id
    else 
      false
    end
  end

  def downvoted_by?(user)
    if user
      self.downvoted_by.include? user.id
    else
      false
    end
  end

  def has_contributor?(user)
    self.contributors.include? user
  end

  def add_contribution(user)
    Contribution.create(:user_id => user.id, :hack_id => self.id)
    create_activity('add_contribution')
  end

  def remove_contribution(user)
    return false if self.contributors.empty? or not has_contributor?(user)
    contributions.where(user_id: user.id).delete_all
    create_activity('remove_contribution')
  end

  def presenting?
    presentation_index.present?
  end

  private

  def initialize_votes
    self.upvoted_by = [] unless self.upvoted_by == []
    self.downvoted_by = [] unless self.downvoted_by == []
  end

  def activity_for_create
    create_activity('create')
  end

  def activity_for_update
    if title_changed? or description_changed? or url_changed?
      create_activity('edit')
    end
  end

  def create_activity(action)
    activities.create(action: action, user_id: User.current.id) if User.current
  end

end
