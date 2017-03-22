class SubredditController < ApplicationController

  before_action :authorize!

  def show
    @subreddit = Subreddit.create(params[:sub])
    @rules = @subreddit.get_rules(params[:sub], current_user.token)

  end
end
