class RedditOauth

  attr_reader :code, :client_id, :client_secret

  def initialize(code)
    @code = code
  end

  def access_token
    response       = Faraday.post("https://www.reddit.com/api/v1/access_token?client_id=#{ENV['reddit_id']}&client_secret=#{ENV['reddit_secret']}&code=#{@code}")
    @access_token   = response.body.split(/\W+/)[1]
    @access_token
  end

  def data
    oauth_response = Faraday.get("https://www.reddit.com/api/v1/access_token=#{@access_token}")
    data           = JSON.parse(oauth_response.body)
    data
  end

end
