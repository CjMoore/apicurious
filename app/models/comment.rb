class Comment

  attr_reader :body,
              :author

  def initialize(body, author)
    @body = body
    @author = author
  end

  def self.create(token, post_id, sub_name)
    serv = RedditService.new(token)
    serv.post_comments(sub_name, post_id).map do |comment|
      comment_data = comment[:data]
      Comment.new(comment_data[:body], comment_data[:author]) unless comment_data[:body].nil? || comment_data[:author].nil?
    end.compact
  end
end
