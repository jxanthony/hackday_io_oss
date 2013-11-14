# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  provider         :string(255)
#  name             :string(255)
#  oauth_token      :string(255)
#  oauth_expires_at :datetime
#  bankroll         :integer          default(10)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  admin            :boolean
#  uid              :integer
#  email            :string(255)
#  mugshot_url      :string(255)
#  mc               :boolean
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
