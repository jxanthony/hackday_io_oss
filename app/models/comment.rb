# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  hack_id    :integer
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  private    :boolean          default(FALSE)
#

class Comment < ActiveRecord::Base
  attr_accessible :body, :hack_id, :user_id, :private

  belongs_to :hack
  belongs_to :user

  validates_presence_of :body, :hack_id, :user_id

  after_save :create_activity

  scope :public, :conditions => { :private => false }


  private

  def create_activity
    hack.activities.create(action: 'comment', user_id: User.current.id) unless private?
  end
end
