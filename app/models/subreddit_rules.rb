class SubredditRules

  def self.create(name, token)
    sub_rules = []
    serv = RedditService.new(token)
    serv.sub_rules(name).each do |rule|
      sub_rules << rule[:description]
    end
    sub_rules
  end
end
