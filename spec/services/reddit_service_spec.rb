require "rails_helper"

describe RedditService do
  attr_reader :service

  before(:each) do
    user = User.create(name: 'iungere', provider: "reddit", uid: "a1z5y", karma: 4, refresh_token: ENV['refresh_token'])
    user.refresh_tokens
    @service = RedditService.new(user.token)
  end

  describe "#user_subreddits" do
    it "returns list of user subreddits" do
      subreddits = @service.user_subreddits
      first_sub = subreddits.first

      expect(subreddits.count).to eq(25)
      expect(first_sub[:data][:display_name]).to eq("politics")
    end
  end

  describe "#sub_rules" do
    it "returns rules for subreddit" do
      subreddit = "politics"
      rules = @service.sub_rules(subreddit)

      expect(rules[:rules].count).to eq(10)
    end
  end

  describe "#sub_hot_posts" do
    it "returns list of hot posts" do
      subreddit = "politics"
      posts = @service.sub_hot_posts(subreddit)

      expect(posts.count).to eq(26)
    end
  end
end
