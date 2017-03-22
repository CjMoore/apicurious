require 'rails_helper'

describe HotPost, type: :model do
  context "class methods" do
    it "can return all hot posts for subreddit" do
      user = User.create(name: 'iungere', provider: "reddit", uid: "a1z5y", karma: 4, refresh_token: ENV['refresh_token'])
      user.refresh_tokens

      subreddit_hot_posts = [ {data: {title: "headline", url: "#" , ups: "12", id: "60z"}},
                              {data: {title: "headline2", url: "#", ups: "24", id: "1s"}}]

      allow_any_instance_of(RedditService).to receive(:sub_hot_posts).and_return(subreddit_hot_posts)

      posts = HotPost.create("politics", user.token)

      expect(posts.first.title).to eq("headline")
      expect(posts.last.title).to eq("headline2")
      expect(posts.count).to eq(2)
    end
  end
end
