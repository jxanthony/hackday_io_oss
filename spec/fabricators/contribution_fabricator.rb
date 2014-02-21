# == Schema Information
#
# Table name: contributions
#
#  id         :integer          not null, primary key
#  hack_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

Fabricator(:contribution) do
end
