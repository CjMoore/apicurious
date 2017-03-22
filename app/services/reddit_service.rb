class RedditService

  def initialize(token)
    @token = token
  end


  def user_subreddits
    parse(HTTParty.get("https://oauth.reddit.com/subreddits/mine/subscriber",
                              :headers => { :Authorization => "bearer #{@token}",
                                            "User-Agent": "apicurious by iungere"}))[:data][:children]

  end

  def sub_rules(subreddit)
   parse(HTTParty.get("https://www.reddit.com/r/#{subreddit}/about/rules.json"))
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
