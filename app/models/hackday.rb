# == Schema Information
#
# Table name: hackdays
#
#  id                       :integer          not null, primary key
#  title                    :string(255)
#  date                     :date
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  presentation_in_progress :boolean
#  group_numbers            :text
#

class Hackday < ActiveRecord::Base
  attr_accessible :date, :title
  has_many :hacks

  serialize :group_numbers
  before_create :setup_group_numbers

  private

  def setup_group_numbers
    self.group_numbers = (1..50).to_a
  end
end
