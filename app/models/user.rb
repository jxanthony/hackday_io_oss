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

class User < ActiveRecord::Base

  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid, :bankroll

  has_many :contributions
  has_many :comments
  has_many :activities

  def self.from_omniauth(auth)
    return false unless YAMMER_NETWORK_IDS.include?(auth.extra.raw_info.network_id)
    user = self.where(:provider => auth.provider, :uid => auth.uid)
    if user.empty?
      user = User.new
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.mugshot_url = auth.info.image
      user.oauth_token = auth.credentials.token
      user.save!
    else
      user = user.first
      user.name = auth.info.name unless user.name == auth.info.name
      user.email = auth.info.email unless user.email == auth.info.email
      user.mugshot_url = auth.info.image unless user.mugshot_url == auth.info.image
      user.save!
    end
    user
  end

end
