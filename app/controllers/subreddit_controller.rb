class SubredditController < ApplicationController

  before_action :authorize!

  def show
    byebug
    @subreddit = Subreddit.find(params[:sub_url])
  end
end
