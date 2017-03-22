class SubredditController < ApplicationController

  before_action :authorize!

  def show
    @subreddit = Subreddit.get_rules(params[:sub], current_user.token)
  end
end
