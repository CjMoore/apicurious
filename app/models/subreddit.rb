class Subreddit

  attr_accessor :rules

  attr_reader :name

  def initialize(name)
    @name = name
    @rules = Array.new
  end

  def get_rules(subreddit_name, token)
    serv = RedditService.new(token)
    # subreddit = Subreddit.new(subreddit_name)
    serv.sub_rules(subreddit_name)[:rules].each do |rule|
      @rules << rule[:description]
    end
    @rules
  end

  def self.create(subreddit_name)
    Subreddit.new(subreddit_name)
  end


end
