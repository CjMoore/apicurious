class SubredditRule

  attr_reader :description

  def initialize(description)
    @description = description
  end

  def self.create(name, token)
    serv = RedditService.new(token)
    serv.sub_rules(name)[:rules].map do |rule|
      SubredditRule.new(rule[:description])
    end
  end
end
