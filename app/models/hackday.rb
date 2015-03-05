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
#

class Hackday < ActiveRecord::Base
  attr_accessible :date, :title, :trophy_name, :trophy_icon, :group_id
  has_many :hacks, :dependent => :destroy
  has_many :activities, through: :hacks
  has_many :comments, through: :hacks
  has_and_belongs_to_many :admins, -> { uniq }, class_name: 'User'

  def has_admin?(user)
    self.admins.include? user
  end

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

  def move_up_in_queue(hack)
    return false if hack.presentation_index.nil? or hack.presentation_index == 1

    swap_target = hacks.find_by_presentation_index(hack.presentation_index - 1)
    swap_target.update_attribute(:presentation_index, hack.presentation_index) if swap_target
    hack.update_attribute(:presentation_index, hack.presentation_index - 1)

    create_activity(hack, 'move_up_in_queue')
  end

  def move_down_in_queue(hack)
    return false if hack.presentation_index.nil? or hack.presentation_index + 1 > queue.size

    swap_target = hacks.find_by_presentation_index(hack.presentation_index + 1)
    swap_target.update_attribute(:presentation_index, hack.presentation_index) if swap_target
    hack.update_attribute(:presentation_index, hack.presentation_index + 1)

    create_activity(hack, 'move_down_in_queue')
  end

  def add_admins(users)
    users.each { |user| add_admin(user) }
  end

  def add_admin(user)
    return unless user
    admins << user
  end

  def delete_admin(user)
    return unless user
    admins.delete(user)
  end

  private

  def bump_queue(index)
    # FIXME: this is absolutely disgusting
    queue.where("presentation_index > #{index}").each do |hack|
      former_index = hack.presentation_index
      hack.update_attribute(:presentation_index, former_index - 1)
    end
  end

  def create_activity(hack, action)
    hack.activities.create(action: action, user_id: User.current.id) if User.current
  end

end
