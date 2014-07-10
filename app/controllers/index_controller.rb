class IndexController < ApplicationController
  include IndexHelper
  
  def show
    if params[:id].nil?
      ids = City.pluck(:id)
      @city = City.find(ids.sample)
    else
      @city = City.find_by_friendly_url(params[:id])
    end 
    raise "I don't know this country or city!" if @city.nil?
    #@countries = City.pluck(:country).uniq
    @countries = City.pluck('DISTINCT country').sort
    @rectangle_coordinates = get_rectangle_coordinates(@city.latitude, @city.longitude, 5).to_json
  end

  def get_cities
    render json: City.select(:id, :city, :friendly_url).where(:country => params[:country])
  end
end
