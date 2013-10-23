class GlobalConfiguration < ActiveRecord::Base
  attr_accessible :presentation_in_progress

  def self.get
    self.first || nil
  end
end
