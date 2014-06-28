class IndexController < ApplicationController
  include IndexHelper
  def index
    @city = City.find(10090)
    p @rectangle_coordinates = get_rectangle_coordinates(@city.latitude, @city.longitude, 5).to_json
  end
end
