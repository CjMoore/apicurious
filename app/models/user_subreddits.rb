class UserSubreddits

  attr_reader :service

  attr_accessor :name,
                :url

  def initialize(name, url)
    @name = name
    @url  = url
  end

  def self.service
    @service ||= RedditService.new
  end

  def self.all(token)
    serv = RedditService.new(token)
    serv.user_subreddits.map do |subreddit|
      UserSubreddits.new(subreddit[:data][:display_name], subreddit[:data][:url])
    end
  end
end
