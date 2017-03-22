require 'rails_helper'

describe UserSubreddits, type: :model do
  context "class methods" do
    it "can return all subreddits for user" do
      user = User.create(name: 'iungere', provider: "reddit", uid: "a1z5y", karma: 4, refresh_token: ENV['refresh_token'])
      user.refresh_tokens

      user_subs = [ { data: { display_name: "politics", url: "/r/politics"}},
                    { data: { display_name: "gaming", url: '/r/gaming' }} ]

      allow_any_instance_of(RedditService).to receive(:user_subreddits).and_return(user_subs)

      subreddits = UserSubreddits.all(user.token)

      expect(subreddits.first.name).to eq("politics")
      expect(subreddits.last.name).to eq("gaming")
      expect(subreddits.count).to eq(2)
    end
  end
end
