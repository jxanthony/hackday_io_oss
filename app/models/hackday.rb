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

  def queue
    hacks.where("presentation_index IS NOT NULL").order("presentation_index ASC")
  end

  def join_queue(hack)
    hack.update_attribute(:presentation_index, queue.size + 1)
  end

  def leave_queue(hack)
    former_index = hack.presentation_index
    hack.update_attribute(:presentation_index, nil)
    bump_queue(former_index)
  end

  private

  def setup_group_numbers
    self.group_numbers = (1..50).to_a
  end

  def bump_queue(index)
    # FIXME: this is absolutely disgusting
    queue.where("presentation_index > #{index}").each do |hack|
      former_index = hack.presentation_index
      hack.update_attribute(:presentation_index, former_index - 1)
    end
  end

end
