require 'spec_helper'

describe Subreddit, type: :model do
  context "methods" do
    it "can create itself" do
      subreddit = Subreddit.create("politics")

      expect(subreddit.name).to eq("politics")
    end

    it "can return an array of rules" do
      subreddit_rules = { rules: [ {description: "dont do that thing"},
                          {description: "do do that thing"}] }

      allow_any_instance_of(RedditService).to receive(:sub_rules).and_return(subreddit_rules)

      subreddit = Subreddit.create("politics")
      rules = subreddit.rules

      expect(rules.count).to eq(2)
      expect(rules.first.class).to eq(SubredditRule)
    end
  end
end
