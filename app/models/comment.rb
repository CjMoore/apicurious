class Comment
  attr_reader :body,
              :author,
              :replies,
              :depth



  def initialize(body, author, reply_data, depth)
    @body = body
    @author = author
    @replies = get_replies(reply_data)
    @depth = depth
  end

  def self.create(token, post_id, sub_name)
    serv = RedditService.new(token)
    serv.post_comments(sub_name, post_id).map do |comment|
      comment_data = comment[:data]
      Comment.new(comment_data[:body], comment_data[:author], comment_data[:replies], comment_data[:depth])
    end
  end

  def get_replies(reply_data)
    replies = []
    unless reply_data.empty?
      reply_data[:data][:children].each do |reply|
        replies << Comment.new(reply[:data][:body], reply[:data][:author], reply[:data][:replies], reply[:data][:depth])
      end
    end
    replies
  end
end
