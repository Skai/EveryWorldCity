module ApplicationHelper
  require 'twitter'
  require 'mini_magick'
  IMG_NAME = 'twitter.jpg'
  TWITTER_TAGS = [
    '#everyworldcity',
    '#world',
    '#travel',
    '#exploretheworld'
  ]

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
        #140 symbols because we have no image link
        response = client.update(get_tweet_text(city), 140)
      end
      city.touch(:sent_at)
    rescue => details
      #remove the city from queue
      city.is_in_twitter = false
      city.save
      # TODO add logger
      p details.backtrace
    end
  end

  def get_tweet_text(city, length = 118)
    #if city name consists of 2 and more words.
    city_tag = city.city.split(' ').join()

    #if county name consists of 2 and more words.
    country_tag = city.country.split(' ').join()

    text = "#{city.city}, #{city.country} http://everyworldcity.com/#{city.friendly_url} ##{country_tag} ##{city_tag} " + TWITTER_TAGS.join(' ')
    
    #Truncate to 118 symbols by default because image link is like http://t.co/1LR5iHgdUE.length = 22, so 118 + 22 = 140.
    text.truncate(length, separator: ' ', omission: '')
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