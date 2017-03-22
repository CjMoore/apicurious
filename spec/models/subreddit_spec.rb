require 'spec_helper'

describe Subreddit, type: :model do
  context "methods" do
    it "can create itself" do
      subreddit = Subreddit.create("politics", "not_token")

      expect(subreddit.name).to eq("politics")
    end
  end
end
