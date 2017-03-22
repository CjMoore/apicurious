class Subreddit

  attr_accessor :rules

  attr_reader :name

  def initialize(name, token)
    @name = name
    @token = token
  end

  def rules
    SubredditRule.create(@name, @token)
  end

  def hot_posts
    HotPost.create(@name, @token)
  end

  def self.create(subreddit_name, token)
    Subreddit.new(subreddit_name, token)
  end
end
