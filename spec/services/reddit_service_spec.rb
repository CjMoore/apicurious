require "rails_helper"

describe RedditService do
  attr_reader :service

  before(:each) do
    user = User.create(name: 'iungere', provider: "reddit", uid: "a1z5y", karma: 4, refresh_token: ENV['refresh_token'])
    VCR.use_cassette("services/refresh_token") do
      user.refresh_tokens
    end
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    @service = RedditService.new(user.token)
  end

  describe "#user_subreddits" do
    it "returns list of user subreddits" do
      VCR.use_cassette("services/user_subreddits") do
        subreddits = @service.user_subreddits
        first_sub = subreddits.first

        expect(subreddits.count).to eq(25)
        expect(first_sub[:data][:display_name]).to eq("politics")
      end
    end
  end

  describe "#sub_rules" do
    it "returns rules for subreddit" do
      VCR.use_cassette("services/sub_rules") do
        subreddit = "politics"
        rules = @service.sub_rules(subreddit)

        expect(rules[:rules].count).to eq(10)
      end
    end
  end

  describe "#sub_hot_posts" do
    it "returns list of hot posts" do
      VCR.use_cassette('services/sub_hot_posts') do
        subreddit = "politics"

        posts = @service.sub_hot_posts(subreddit)

        expect(posts.count).to eq(27)
      end
    end
  end

  describe "#post_comments" do
    it "returns list of comments for post" do
      VCR.use_cassette("services/post_comments") do
        subreddit = "APICurious"
        post_id = "576a5l"

        comments = @service.post_comments(subreddit, post_id)

        expect(comments.count).to eq(2)
      end
    end
  end
end
