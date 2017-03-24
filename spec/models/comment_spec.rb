require 'rails_helper'

describe Comment, type: :model do
  context "class methods" do
    it "return all comments and their replies" do
      comments_hash = [{ data: { body: "comment1", author: "me", depth: "0", replies: { data: { children: [ { data: { body: "comment2", author: "me", depth: "1", replies: []}} ]}}} } ]

      allow_any_instance_of(RedditService).to receive(:post_comments).and_return(comments_hash)

      comments = Comment.create( "post_id", "subreddit")

      expect(comments.count).to eq(1)
      expect(comments.first.replies.count).to eq(1)
    end
  end
end
