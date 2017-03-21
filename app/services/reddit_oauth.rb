class RedditOauth

  attr_reader :code, :client_id, :client_secret

  def initialize(code)
    @code = code
  end

  def access_token
    response       = HTTParty.post("https://www.reddit.com/api/v1/access_token",
                                    :body => { :grant_type => "authorization_code",
                                               :code => @code,
                                               :redirect_uri => 'http://localhost:3000/auth/reddit/callback'},
                                    :basic_auth => {:username => ENV['reddit_id'],
                                                    :password => ENV['reddit_secret']} )


    @access_token   = JSON.parse(response.body)['access_token']
    @access_token
  end

  def data
    headers =
    oauth_response =  HTTParty.get("https://oauth.reddit.com/api/v1/me",
                                    :headers => { :Authorization => "bearer #{@access_token}",
                                                  "User-Agent": "apicurious by iungere"})
    data           = JSON.parse(oauth_response.body)
    data
  end

end
