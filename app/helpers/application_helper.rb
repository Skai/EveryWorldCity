#encoding: utf-8
module ApplicationHelper
  require 'twitter'
  require 'mini_magick'
  require 'open-uri'

  
  IMG_NAME = 'twitter.jpg'
  EWC_COPYRIGHT = "© www.everyworldcity.com"
  WIKI_COPYRIGHT = "© wikipedia.org"

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

      if !city.twitter_image_file_name.nil?
        copyright = city.copyright_text.empty? ? EWC_COPYRIGHT : city.copyright_text
        copy_file_for_post(city)
      elsif !city.wiki_image_src.nil?
        copyright = city.copyright_text.empty? ? WIKI_COPYRIGHT : city.copyright_text
        download_file_for_post(city)
      else
        #if city doesn't have wiki image
        #140 symbols because we have no image link
        return client.update(get_tweet_text(city), 140)
      end

      add_text_watermark(copyright)
      
      File.open(IMG_NAME,'rb') do |file|
        client.update_with_media(
          get_tweet_text(city),
          file
        )
      end
    
      city.touch(:sent_at)
    rescue => details
      #remove the city from queue
      city.is_in_twitter = false
      city.save
      p details.message
      p details.backtrace
    end
  end

  def copy_file_for_post(city)
    FileUtils.copy_file(
      "#{Rails.root}/public/images/#{city.id}/medium/#{city.twitter_image_file_name}",
      IMG_NAME
    )
  end

  def download_file_for_post(city)
    open(city.wiki_image_src) do |f|
      File.open(IMG_NAME,'wb') do |file|
        file.puts f.read
      end
    end
  end

  def get_tweet_text(city, length = 118)
    #if city name consists of 2 and more words.
    city_tag = city.city.split(' ').join()

    #if county name consists of 2 and more words.
    country_tag = city.country.split(' ').join()

    text = "#{city.city}, #{city.country} http://everyworldcity.com/#{city.friendly_url} ##{country_tag} ##{city_tag} " + TWITTER_TAGS.join(' ')
    
    #Truncate to 118 symbols by default because image link is like 'http://t.co/1LR5iHgdUE'.length = 22, so 118 + 22 = 140.
    text.truncate(length, separator: ' ', omission: '')
  end

  def add_text_watermark(copyright = WIKI_COPYRIGHT)
    if File.exist?(IMG_NAME)
      image = MiniMagick::Image.open(IMG_NAME)
      image.combine_options do |c|
        c.gravity 'Southeast'
        c.pointsize '21'
        c.font "Helvetica"
        c.draw "text 3,0 '#{copyright} \n'"
        c.fill("#fff")
        c.draw "text 0,0 '#{copyright} \n'"
        c.fill("#000")
      end

      image.write(IMG_NAME)
    end
  end
end