# == Schema Information
#
# Table name: comments
#
#  id            :integer          not null, primary key
#  hack_id       :integer
#  body          :text
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  admin_comment :boolean
#

class Comment < ActiveRecord::Base
  attr_accessible :body, :hack_id, :user_id, :admin_comment

  belongs_to :hack
  belongs_to :user

  validates_presence_of :body, :hack_id, :user_id

  after_save :create_activity


  private

  def create_activity
    hack.activities.create(action: 'comment', user_id: User.current.id) unless admin_comment?
  end
end
