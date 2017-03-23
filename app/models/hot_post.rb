class HotPost

  attr_reader :title,
              :url,
              :ups,
              :id,
              :sub_name

  def initialize(title, url, ups, id, sub_name=nil, token=nil)
    @title = title
    @url = url
    @ups = ups
    @id = id
    @token = token
    @sub_name = sub_name
  end

  def self.create(name, token)
    serv = RedditService.new(token)
    serv.sub_hot_posts(name).map do |post|
      data = post[:data]
      HotPost.new(data[:title], data[:url], data[:ups], data[:id])
    end
  end

  def self.find(title, url, ups, id, sub_name, token)
    HotPost.new(title, url, ups, id, sub_name, token)
  end

  def comments
    Comment.create(@token, @id, @sub_name)
  end
end
