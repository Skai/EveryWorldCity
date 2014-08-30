module ApplicationHelper
  require 'twitter'

  def tweet(city)
    client = Twitter::REST::Client.new do |config| #should be moved for secure reasone
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
    
    file_url = city.wiki_image_src
    temp_file = 'twitter.jpg'
    open(file_url) do |f|
      File.open(temp_file,'wb') do |file|
        file.puts f.read
      end
      File.open(temp_file,'rb') do |file|
        response = client.update_with_media(
          get_tweet_text(city), 
          file
        )
        city.touch(:sent_at) if response.id
      end
    end
  end

  #TODO: Add length checker. Add solution for city with two world.
  def get_tweet_text(city)
    "#{city.city}, #{city.country} http://everyworldcity.com/#{city.friendly_url} ##{city.country} ##{city.city} #everyworldcity #world #travel"
  end
end