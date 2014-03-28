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
#  presentation_index :integer
#  upvoted_by         :text             default("'")
#  downvoted_by       :text             default("'")
#  hackday_id         :integer
#

Fabricator(:hack) do
  title "Test Hack"
  description "test description that is so testy it hurts"
  contributions(count: 3) do |attrs, i|
    Fabricate(:contribution, user: Fabricate(:user, name: "Person #{i}"))
  end
end
