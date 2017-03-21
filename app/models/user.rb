class User < ApplicationRecord

  def self.from_reddit(data, access_token)
    user           = User.find_or_create_by(uid: data['id'], provider: 'reddit')
    user.name  = data['login']
    user.token     = access_token
    user.save
    user
  end
end
