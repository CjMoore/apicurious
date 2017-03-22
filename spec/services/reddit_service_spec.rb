require "rails_helper"

describe RedditService do
  attr_reader :service

  before(:each) do
    user = User.create(name: 'iungere', provider: "reddit", uid: "a1z5y", token: "Y6U8WBVO6SnGuriG8Q0M5Bi_0ic", karma: 4, refresh_token: "16888390-nljBZBj2C1TdEK8PyT1-6PPGYtM")
    user.refresh_tokens
    # byebug
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
end
