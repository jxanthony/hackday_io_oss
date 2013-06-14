# == Schema Information
#
# Table name: contributions
#
#  id         :integer          not null, primary key
#  hack_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Contribution < ActiveRecord::Base
  attr_accessible :hack_id, :user_id

  belongs_to :user
  belongs_to :hack
end
