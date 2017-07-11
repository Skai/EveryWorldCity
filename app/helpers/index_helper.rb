#helper for index controller
module IndexHelper
  require 'httpclient'

  GOOGLE_PLACE_SEARCH_URI = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
  GOOGLE_PLACE_PHOTOS_URI = 'https://maps.googleapis.com/maps/api/place/photo'
  GOOGLE_APP_KEY          = 'AIzaSyB_qIgbHmPe5XEsSk189fWyjCW_-YafowA'#ENV['GOOGLE_APP_KEY']

  MOBILE_BROWSERS = ["playbook", "windows phone", "android", "ipod", "iphone", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]

  # Detects if it is request from mobile device.
  def is_mobile
    user_agent = request.headers["HTTP_USER_AGENT"].downcase
    MOBILE_BROWSERS.each do |m|
      return true if user_agent.match(m)
    end
    false
  end

  def google_photos_json (center_lat, center_lon)

    # get place info
    place_info = place_info_json(center_lat, center_lon)
    return false if place_info == false

    photos = []

    place_info['results'].each_with_index do |result,index|
      next if result['photos'].blank?
      photos << {
        title: result['name'],
        photo: google_photo_url(result['photos'][0]['photo_reference'])
      }
    end

    photos
  end

  def place_info_json(center_lat, center_lon)
    # get place info
    request_params = {
      key:      GOOGLE_APP_KEY,
      location: "#{center_lat},#{center_lon}",
      radius:   5000
    }

    response = HTTPClient.new.get(GOOGLE_PLACE_SEARCH_URI , request_params)

    return false if response.status != 200
    JSON.parse(response.body)
  end

  def google_photo_url(reference)
    request_params = {
      key:      GOOGLE_APP_KEY,
      photoreference: reference,
      maxwidth:       is_mobile ? '640' : '1920',
      maxheight:      is_mobile ? '480' : '1280'
    }

    "#{GOOGLE_PLACE_PHOTOS_URI}?#{request_params.to_query}"
  end

  def get_staticmap_url(latitude, longitude, marker_color = '0xff765e', label = '*')
    "http://maps.googleapis.com/maps/api/staticmap?center=#{latitude},#{longitude}&zoom=6&size=600x600&language=en&sensor=true&markers=color:#{marker_color}%7Clabel:#{label}%7C#{latitude},#{longitude}"
  end

  def get_wiki_url(wiki_page_id)
    "http://en.wikipedia.org/wiki?curid=#{wiki_page_id}"
  end

  def get_googlemap_url(latitude, longitude)
    "http://maps.google.com/?q=#{latitude},#{longitude}"
  end
end
