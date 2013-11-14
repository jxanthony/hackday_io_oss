# == Schema Information
#
# Table name: admin_comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AdminComment < ActiveRecord::Base
  attr_accessible :body, :user_id

  belongs_to :user
end
