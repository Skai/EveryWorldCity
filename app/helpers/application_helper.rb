module ApplicationHelper
  require 'twitter'
  require 'mini_magick'
  IMG_NAME = 'twitter.jpg'

  def tweet(city)
    begin 
      client = Twitter::REST::Client.new do |config| #should be moved for secure reasone
        config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
        config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
      end
    
      unless city.wiki_image_src.nil?
        file_url = city.wiki_image_src
        open(file_url) do |f|
          File.open(IMG_NAME,'wb') do |file|
            file.puts f.read
          end
        end
        File.open(IMG_NAME,'rb') do |file|
          add_text_watermark
          response = client.update_with_media(
            get_tweet_text(city), 
            file
          )
        end
      else 
        #if city doesn't have wiki image
        response = client.update(get_tweet_text(city))
      end
      city.touch(:sent_at) if response
    rescue => details
      # TODO add logger
      p details.backtrace.join("\n")
    end
  end

  #TODO: Add length checker. Add solution for city with two world.
  def get_tweet_text(city)
    "#{city.city}, #{city.country} http://everyworldcity.com/#{city.friendly_url} ##{city.country} ##{city.city} #everyworldcity #world #travel"
  end

  def add_text_watermark
    if File.exist?(IMG_NAME)
      image = MiniMagick::Image.open(IMG_NAME)
      result = image.composite(MiniMagick::Image.open("copyright.png", "jpg")) do |c|
        c.gravity "southeast"
      end
      result.write IMG_NAME
    end
  end
end