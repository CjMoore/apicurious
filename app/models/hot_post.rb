class HotPost

  attr_reader :title,
              :url,
              :ups,
              :id,
              :sub_name,
              :thumbnail

  def initialize(data, thumbnail=nil, sub_name=nil)
    @title = data[:title]
    @url = data[:url]
    @ups = data[:ups]
    @id = data[:id]
    @sub_name = sub_name
    @thumbnail = thumbnail
  end

  def self.create(name)
    serv = RedditService.new
    serv.sub_hot_posts(name).map do |post|
      data = post[:data]
      HotPost.new(data, data[:thumbnail])
    end
  end

  def self.find(data)
    HotPost.new(data, data[:thumbnail], data[:sub_name])
  end

  def comments
    Comment.create(@id, @sub_name)
  end
end
