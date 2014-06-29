class IndexController < ApplicationController
  include IndexHelper
  
  def show
    #@city = City.find(params[:id])

    @city = City.find_by_friendly_url(params[:id])

    p @rectangle_coordinates = get_rectangle_coordinates(@city.latitude, @city.longitude, 5).to_json
  end
end
