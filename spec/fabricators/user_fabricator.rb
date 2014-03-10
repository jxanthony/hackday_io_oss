# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  provider         :string(255)
#  name             :string(255)
#  oauth_token      :string(255)
#  oauth_expires_at :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  uid              :integer
#  email            :string(255)
#  mugshot_url      :string(255)
#

Fabricator(:user) do
  name "Kane Ren"
  provider "yammer"
  email "kane@ren.com"
  mugshot_url ""
end
