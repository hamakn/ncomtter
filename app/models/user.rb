class User < ActiveRecord::Base
  attr_accessible :nickname, :provider, :secret, :token, :uid

  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.nickname = auth["info"]["nickname"]
      user.token = auth["credentials"]["token"]
      user.secret = auth["credentials"]["secret"]
    end
  end

  def following(cursor = -1)
    twitter_client.following({:count => 200, :cursor => cursor})
  end

  private

  def twitter_client
    @client ||= ::Twitter::Client.new({
      :consumer_key => ENV["TWITTER_KEY"],
      :consumer_secret => ENV["TWITTER_SECRET"],
      :oauth_token => self.token,
      :oauth_token_secret => self.secret,
    })
  end
end
