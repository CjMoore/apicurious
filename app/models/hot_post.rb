class HotPost

  attr_reader :title,
              :url,
              :ups

  def initialize(title, url, ups)
    @title = title
    @url = url
    @ups = ups
  end

  def self.create(name, token)
    serv = RedditService.new(token)
    serv.sub_hot_posts(name).map do |post|
      data = post[:data]
      HotPost.new(data[:title], data[:url], data[:ups])
    end
  end
end
