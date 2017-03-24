class HotPost

  attr_reader :title,
              :url,
              :ups,
              :id,
              :sub_name

  def initialize(data, sub_name=nil)
    @title = data[:title]
    @url = data[:url]
    @ups = data[:ups]
    @id = data[:id]
    @sub_name = sub_name
    @thumbnail = nil
  end

  def self.create(name)
    serv = RedditService.new
    serv.sub_hot_posts(name).map do |post|
      data = post[:data]
      HotPost.new(data)
    end
  end

  def self.find(data)
    HotPost.new(data, data[:sub_name])
  end

  def comments
    Comment.create(@id, @sub_name)
  end
end
