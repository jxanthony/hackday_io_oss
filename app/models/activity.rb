class Activity < ActiveRecord::Base
  attr_accessible :action, :hack_id, :user_id

  belongs_to :user
  belongs_to :hack
end
