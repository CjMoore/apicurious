class RedditService

  def initialize(token=nil)
    @token = token
  end


  def user_subreddits
    parse(HTTParty.get("https://oauth.reddit.com/subreddits/mine/subscriber.json?limit=100",
                              :headers => { :Authorization => "bearer #{@token}",
                                            "User-Agent": "apicurious by iungere"}))[:data][:children]

  end

  def sub_rules(subreddit)
   parse(HTTParty.get("https://www.reddit.com/r/#{subreddit}/about/rules.json"))
  end

  def sub_hot_posts(subreddit)
    parse(HTTParty.get("https://www.reddit.com/r/#{subreddit}/hot.json"))[:data][:children]
  end

  def post_comments(subreddit, post_id)
    parse(HTTParty.get("https://www.reddit.com/r/#{subreddit}/comments/#{post_id}.json?depth=4"))[1][:data][:children]
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
