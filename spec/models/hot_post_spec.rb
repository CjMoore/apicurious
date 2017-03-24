require 'rails_helper'

describe HotPost, type: :model do
  context "class methods" do
    it "can return all hot posts for subreddit" do
      subreddit_hot_posts = [ {data: {title: "headline", url: "#" , ups: "12", id: "60z"}},
                              {data: {title: "headline2", url: "#", ups: "24", id: "1s"}}]

      allow_any_instance_of(RedditService).to receive(:sub_hot_posts).and_return(subreddit_hot_posts)

      posts = HotPost.create("politics")

      expect(posts.first.title).to eq("headline")
      expect(posts.last.title).to eq("headline2")
      expect(posts.count).to eq(2)
    end

    it "can create a new post with find that includes token and subreddit" do
      input_data = {title: "title", url: "/url", id: "id12", ups: "140", sub_name: "politics"}
      post = HotPost.find(input_data)

      expect(post.class).to eq(HotPost)
      expect(post.title).to eq("title")
      expect(post.url).to eq("/url")
      expect(post.ups).to eq("140")
      expect(post.sub_name).to eq("politics")
      expect(post.id).to eq("id12")
    end
    it "can return an array of comments" do

      comments_hash = [{ data: { body: "comment1", author: "me", depth: "0", replies: { data: { children: [ { data: { body: "comment2", author: "me", depth: "1", replies: []}} ]}}} } ]

      allow_any_instance_of(RedditService).to receive(:post_comments).and_return(comments_hash)

      input_data = {title: "title", url: "/url", ups: "140"}

      posts = HotPost.find(input_data)

      comments = posts.comments

      expect(comments.count).to eq(1)
      expect(comments.first.replies.count).to eq(1)
      expect(comments.first.class).to eq(Comment)
    end
  end
end
