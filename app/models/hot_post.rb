class HotPost

  attr_reader :title,
              :url,
              :ups,
              :id

  def initialize(title, url, ups, id)
    @title = title
    @url = url
    @ups = ups
    @id = id
  end

  def self.create(name, token)
    serv = RedditService.new(token)
    serv.sub_hot_posts(name).map do |post|
      data = post[:data]
      HotPost.new(data[:title], data[:url], data[:ups], data[:id])
    end
  end
end
