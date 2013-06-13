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
end
