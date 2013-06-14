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
  attr_accessible :description, :score, :title, :votes

  has_many :comments
  has_many :contributors

  def upvote(user)
    self.votes += 1
    user.bankroll -= 1

    self.save
    user.save

    h = CONNECTION.post("/api/v1/messages.json?group_id=2032538&body=heyhighlife", nil, HEADERS)
    raise h.inspect

  end

  def downvote(user)
    self.votes -= 1
    user.bankroll -= 1

    self.save
    user.save
  end

  def has_contributor?(user)
    self.contributors.detect { |contributor| c.user_id == user.id }
  end

  def add_contributor(user)
    Contributor.create(:user_id => user.id, :hack_id => self.id)
  end

  def remove_contributor(user)
    self.contributors.detect { |contributor| c.user_id == user.id }.destroy
  end

end
