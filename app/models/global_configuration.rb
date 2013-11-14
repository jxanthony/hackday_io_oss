# == Schema Information
#
# Table name: global_configurations
#
#  id                       :integer          not null, primary key
#  presentation_in_progress :boolean
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  group_numbers            :text
#

class GlobalConfiguration < ActiveRecord::Base
  attr_accessible :presentation_in_progress, :group_numbers

  serialize :group_numbers

  def self.get
    self.first || nil
  end
end
