class User < ApplicationRecord

  def self.from_reddit(data, access_token)
    user           = User.find_or_create_by(uid: data['id'], provider: 'reddit')
    user.name      = data['name']
    user.token     = access_token[0]
    user.refresh_token = access_token[1]
    user.karma     = data['link_karma']
    user.save
    user
  end

  def refresh_tokens
    token_request = RedditOauth.new
    token_request.refresh_tokens(refresh_token)
    update_attribute(:token, token_request.refresh_tokens(refresh_token))
  end

  def subreddits
    UserSubreddits.all(token)
  end
end
