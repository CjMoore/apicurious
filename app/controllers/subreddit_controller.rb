class SubredditController < ApplicationController

  before_action :authorize!

  def show
    @subreddit = Subreddit.create(params[:sub], current_user.token)
    @rules = @subreddit.get_rules
  end
end
