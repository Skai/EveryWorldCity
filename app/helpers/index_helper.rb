#helper for index controller
module IndexHelper
  require 'httpclient'

  EARTH_RADIUS = 6371.0
  PANORAMIO_REQUEST_URI = 'http://www.panoramio.com/map/get_panoramas.php'
  CITY_RADIUS = 5
  DEFAULT_PANORAMIO_PARAMS = {
    :set => :public,
    :size => :original,
    :from => 0,
    :to => 40,
    :order => :popularity
  }

  #Returns request url for panoramin REST API.
  #Input data: 
  #center coordinate: lat, lon.
  #radius of circumscribed circle.
  #Returns e.g. http://www.panoramio.com/map/get_panoramas.php??order=popularity&set=public&from=0&to=20&minx=36.180045197483096
  #&miny=49.955033919704064&maxx=36.319954802516904&maxy=50.044966080295936&size=original
  def get_panoramio_json (center_lat, center_lon)
    request_params = DEFAULT_PANORAMIO_PARAMS
    request_params[:minx] = get_minx(center_lon, center_lat)
    request_params[:miny] = get_miny(center_lat)
    request_params[:maxx] = get_maxx(center_lon, center_lat)
    request_params[:maxy] = get_maxy(center_lat)
    
    client = HTTPClient.new
    response = client.get(PANORAMIO_REQUEST_URI , request_params)
    response.status == 200 ? (response.body) : false
  end

  #Returns coordinates of the rectangle - southwest and northeast corners.
  #Input data: 
  #center coordinate: lat, lon.
  #radius of circumscribed circle.
  def get_rectangle_coordinates(center_lat, center_lon)
    # panoramio uses such format {'sw': {'lat': -30, 'lng': 10.5}, 'ne': {'lat': 50.5, 'lng': 30}}
    # Radius of the Earth, in kilometers.
    # http://en.wikipedia.org/wiki/Earth_radius
    r_coordinates = {
      sw: {
        lat: get_miny(center_lat),
        lng: get_minx(center_lon, center_lat)
      },
      ne: {
        lat: get_maxy(center_lat),
        lng: get_maxx(center_lon, center_lat)
      }
    }
  end

  def get_minx(center_lon, center_lat)
    center_lon - (CITY_RADIUS / longitude_degree_distance(center_lat))
  end
  
  def get_maxx(center_lon, center_lat)
    center_lon + (CITY_RADIUS / longitude_degree_distance(center_lat))
  end

  def get_miny(center_lat)
    center_lat - (CITY_RADIUS / latitude_degree_distance)
  end

  def get_maxy(center_lat)
    center_lat + (CITY_RADIUS / latitude_degree_distance)
  end

  def latitude_degree_distance
    2 * Math::PI * EARTH_RADIUS / 360
  end

  def longitude_degree_distance(latitude)
    latitude_degree_distance * Math.cos(to_radians(latitude))
  end

  def to_radians(value)
    value * (Math::PI / 180)
  end

  def get_staticmap_url(latitude, longitude, marker_color = '0x00b597', label = 'E')
    "http://maps.googleapis.com/maps/api/staticmap?center=#{latitude},#{longitude}&zoom=6&size=600x600&sensor=true&markers=color:#{marker_color}%7Clabel:#{label}%7C#{latitude},#{longitude}"
  end

  def get_wiki_url(wiki_page_id)
    "http://en.wikipedia.org/wiki?curid=#{wiki_page_id}"
  end

  def get_googlemap_url(latitude, longitude) 
    "http://maps.google.com/?q=#{latitude},#{longitude}"
  end
end