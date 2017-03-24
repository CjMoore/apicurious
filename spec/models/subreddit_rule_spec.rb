require 'rails_helper'

describe SubredditRule, type: :model do
  context "class methods" do
    it "can return all rules for subreddit" do
      subreddit_rules = { rules: [ {description: "dont do that thing"},
                          {description: "do do that thing"}] }

      allow_any_instance_of(RedditService).to receive(:sub_rules).and_return(subreddit_rules)

      rules = SubredditRule.create("politics")

      expect(rules.count).to eq(2)
      expect(rules.first.description).to eq("dont do that thing")
      expect(rules.last.description).to eq("do do that thing")
    end
  end
end
