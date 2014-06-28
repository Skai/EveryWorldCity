module IndexHelper
  EARTH_RADIUS = 6371.0

  #Returns coordinates of the rectangle - southwest and northeast corners.
  #Input data: 
  #center coordinate: lat, lon.
  #radius of circumscribed circle.
  def get_rectangle_coordinates(center_lat, center_lon, radius)
    # panoramio uses such format {'sw': {'lat': -30, 'lng': 10.5}, 'ne': {'lat': 50.5, 'lng': 30}}
    # Radius of the Earth, in kilometers.
    # http://en.wikipedia.org/wiki/Earth_radius

    r_coordinates = {
      sw: {
        lat: center_lat - (radius / latitude_degree_distance),
        lng: center_lon - (radius / longitude_degree_distance(center_lat))
      },
      ne: {
        lat: center_lat + (radius / latitude_degree_distance),
        lng: center_lon + (radius / longitude_degree_distance(center_lat))
      }
    }
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
end