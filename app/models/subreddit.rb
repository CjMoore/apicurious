class Subreddit

  attr_accessor :rules

  attr_reader :name

  def initialize(name)
    @name = name
    @rules = Array.new
  end

  def self.get_rules(subreddit_name, token)
    serv = RedditService.new(token)
    subreddit = Subreddit.new(subreddit_name)

    serv.sub_rules(subreddit_name)[:rules].each do |rule|
      subreddit.rules << rule[:description]
    end
    subreddit
  end
end
