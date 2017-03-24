class SubredditController < ApplicationController

  before_action :authorize!

  def show
    @subreddit = Subreddit.create(params[:sub])
    @rules = @subreddit.rules
    @hot_posts = @subreddit.hot_posts
  end
end
