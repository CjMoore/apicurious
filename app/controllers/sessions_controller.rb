class SessionsController < ApplicationController

  def create
    reddit_oauth      = RedditOauth.new(params['code'])
    access_token      = reddit_oauth.access_token

    data              = reddit_oauth.data


    user              = User.from_reddit(data, access_token)

    session[:user_id] = user.id
    redirect_to dashboard_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
