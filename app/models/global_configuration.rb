class GlobalConfiguration < ActiveRecord::Base
  attr_accessible :presentation_in_progress, :group_numbers

  serialize :group_numbers

  def self.get
    self.first || nil
  end
end
