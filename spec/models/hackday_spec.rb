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

require 'spec_helper'

describe Hackday do

  it "has a valid fabricator" do
    Fabricate(:hackday).should be_valid
  end

  it "requires a title"
  it "requires a date"

  it "has a set of group numbers" do
    hackday = Fabricate(:hackday)
    hackday.group_numbers have(50).items
  end
end
