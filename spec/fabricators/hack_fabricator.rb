# == Schema Information
#
# Table name: hacks
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  description        :text(255)
#  votes              :integer          default(0)
#  url                :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  requested_hackers  :integer
#  presentation_index :integer
#  creator_id         :integer
#  upvoted_by         :text             default("'--- []\n'")
#  downvoted_by       :text             default("'--- []\n'")
#  group_number       :integer
#  hackday_id         :integer
#

Fabricator(:hack) do
  title "Test Hack"
  description "test description that is so testy it hurts"
  contributions(count: 3) do |attrs, i|
    Fabricate(:contribution, user: Fabricate(:user, name: "Person #{i}"))
  end
end