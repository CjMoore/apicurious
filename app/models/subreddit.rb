class Subreddit

  attr_accessor :rules

  attr_reader :name

  def initialize(name)
    @name = name
    # @token = token
  end

  def rules
    SubredditRule.create(@name)
  end

  def hot_posts
    HotPost.create(@name)
  end

  def self.create(subreddit_name)
    Subreddit.new(subreddit_name)
  end
end
