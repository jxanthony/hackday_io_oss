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

Fabricator(:hackday) do
  title "Hackapalooza"
  date Date.parse("Oct 31, 2013")
end
