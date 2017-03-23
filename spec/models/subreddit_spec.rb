require 'spec_helper'

describe Subreddit, type: :model do
  context "methods" do
    it "can create itself" do
      subreddit = Subreddit.create("politics", "not_token")

      expect(subreddit.name).to eq("politics")
    end

    it "can return an array of rules" do
      user = User.create(name: 'iungere', provider: "reddit", uid: "a1z5y", karma: 4, refresh_token: ENV['refresh_token'])
      user.refresh_tokens

      subreddit_rules = { rules: [ {description: "dont do that thing"},
                          {description: "do do that thing"}] }

      allow_any_instance_of(RedditService).to receive(:sub_rules).and_return(subreddit_rules)

      subreddit = Subreddit.create("politics", user.token)
      rules = subreddit.rules

      expect(rules.count).to eq(2)
      expect(rules.first.class).to eq(SubredditRule)
    end
  end
end
