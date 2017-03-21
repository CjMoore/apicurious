require "rails_helper"

describe RedditService do
  attr_reader :service

  before(:each) do
    @service = RedditService.new
  end

  describe "#user_subreddits" do
    it "returns list of user subreddits" do
      user = User.create(name: 'iungere', provider: "reddit", uid: "a1z5y", token: "02ja_xU1uiAf6xPN8PjOocJ3nyE", karma: 4)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      subreddits = @service.user_subreddits
      first_sub = subreddits.first
      expect(subreddits.count).to eq(10)
    end
  end
end
