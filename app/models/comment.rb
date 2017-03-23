class Comment
#
  attr_reader :body,
              :author,
              :replies



  def initialize(body, author, reply_data)
    @body = body
    @author = author
    @replies = get_replies(reply_data)
  end
#
#
  def self.create(token, post_id, sub_name)
    serv = RedditService.new(token)
    comments = []
    serv.post_comments(sub_name, post_id).map do |comment|
      comment_data = comment[:data]
      Comment.new(comment_data[:body], comment_data[:author], comment_data[:replies])
    end
  end
#
  def get_replies(reply_data)
    replies = []
    unless reply_data.empty?
      reply_data[:data][:children].each do |reply|
        replies << Comment.new(reply[:data][:body], reply[:data][:author], reply[:data][:replies])
      end
    end
    replies
  end
#
#   # def self.get_replies(comment_data, comments)
#   #   if comment_data[:replies].is_a?(Hash)
#   #     replies = comment_data[:replies][:data][:children]
#   #     comment = Comment.new(comment_data[:body], comment_data[:author])
#   #     Comment.create_children(comment_data, replies, comments, comment)
#   #   else
#   #     comments << Comment.new(comment_data[:body], comment_data[:author]) if comment_data[:depth] == 0
#   #   end
#   # end
#   #
#   # def self.create_children(comment_data, replies, comments, comment)
#   #   new_comment = Comment.new(comment_data[:body], comment_data[:author])
#   #   if comment_data[:depth] == 0
#   #     comments << new_comment
#   #   else
#   #     comment.children << new_comment
#   #   replies.each do |reply|
#   #     reply_data = reply[:data]
#   #     if reply_data[:replies].is_a?(Hash)
#   #       replies = reply_data[:replies][:data][:children]
#   #       reply = Comment.new(reply_data[:body], reply_data[:author])
#   #       new_comment.children << reply
#   #       Comment.create_children(reply_data, replies, comments, reply)
#   #     else
#   #       new_comment.children << Comment.new(reply_data[:body], reply_data[:author])
#   #     end
#   #   end
#   # end
end
