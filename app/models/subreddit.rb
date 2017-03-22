class Subreddit

  attr_accessor :rules

  attr_reader :name

  def initialize(name, token)
    @name = name
    @rules = Array.new
    @token = token
  end

  def rules
    @rules = SubredditRules.create(@name, @token)
    @rules
  end

  def self.create(subreddit_name, token)
    Subreddit.new(subreddit_name, token)
  end


end
