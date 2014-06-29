class IndexController < ApplicationController
  include IndexHelper
  
  def show
    if params[:id].nil?
      ids = City.pluck(:id)
      @city = City.find(ids.sample)
    else
      @city = City.find_by_friendly_url(params[:id])
    end
    @rectangle_coordinates = get_rectangle_coordinates(@city.latitude, @city.longitude, 5).to_json
  end
end
