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

class User < ActiveRecord::Base
  searchable do
    text :name
  end
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid, :bankroll, :mugshot_url

  has_many :contributions
  has_many :comments
  has_many :activities

  def self.from_omniauth(auth)
    user = self.where(provider: auth[:provider], uid: auth[:uid])
    if user.empty?
      user = User.new
      user.provider = auth[:provider]
      user.uid = auth[:uid]
      user.oauth_token = auth[:credentials][:token]
    else 
      user = user.first
    end
    user.name = auth[:info][:name]
    user.email = auth[:info][:email]
    user.mugshot_url = auth[:info][:image]
    user.save!

    user
  end

  def self.current
    Thread.current[:user]
  end
  
  def self.current=(user)
    Thread.current[:user] = user
  end

  def winning_hacks
    hacks.reject {|h| h.trophy.nil? | h.trophy.blank?}
  end

  def trophies
      winning_hacks.map {|h| h.hackday.trophy_icon}
  end

  def trophy_names
    winning_hacks.map {|h| h.trophy}
  end

  def hacks
    @hacks ||= contributions.map(&:hack)
  end

end
