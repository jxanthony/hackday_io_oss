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

class Activity < ActiveRecord::Base
  attr_accessible :action, :hack_id, :user_id

  belongs_to :user
  belongs_to :hack
end
