class User < ActiveRecord::Base
  attr_accessible :nickname, :provider, :secret, :token, :uid
end
