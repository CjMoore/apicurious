class Comment

  attr_reader :body,
              :author

  attr_accessor :children

  def initialize(body, author)
    @body = body
    @author = author
    @children = []
  end


  def self.create(token, post_id, sub_name)
    serv = RedditService.new(token)
    comments = []
    serv.post_comments(sub_name, post_id).each do |comment|
      comment_data = comment[:data]
      Comment.get_replies(comment_data, comments)
    end
    comments
  end

  def self.get_replies(comment_data, comments)
    if comment_data[:replies].is_a?(Hash)
      replies = comment_data[:replies][:data][:children]
      Comment.create_children(comment_data, replies, comments)
    else
      comments << Comment.new(comment_data[:body], comment_data[:author]) if comment_data[:depth] == 0
    end
  end

  def self.create_children(comment_data, replies, comments)
    comment = Comment.new(comment_data[:body], comment_data[:author])
    comments << comment if comment_data[:depth] == 0
    replies.each do |reply|
      reply_data = reply[:data]
      if reply_data[:replies].is_a?(Hash)
        replies = reply_data[:replies][:data][:children]
        comment.children << Comment.new(reply_data[:body], reply_data[:author])
        Comment.create_children(reply_data, replies, comments)
      else
        comment.children << Comment.new(reply_data[:body], reply_data[:author])
      end
    end
  end
end
