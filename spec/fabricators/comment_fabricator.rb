# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  hack_id    :integer
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  private    :boolean          default(FALSE)
#

Fabricator(:comment) do
  body "This hack sux"
end
