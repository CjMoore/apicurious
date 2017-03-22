class Subreddit

  attr_accessor :rules

  attr_reader :name

  def initialize(name, token)
    @name = name
    @rules = Array.new
    @token = token
  end

  def get_rules
    serv = RedditService.new(@token)
    serv.sub_rules(@name).each do |rule|
      @rules << rule[:description]
    end
    @rules
  end

  def self.create(subreddit_name, token)
    Subreddit.new(subreddit_name, token)
  end


end
