class IndexController < ApplicationController
  include IndexHelper
  
  def show
    #show random city for homepage.
    if params[:id].nil?
      @city = City.limit(1).order('RANDOM()').first
    else
      @city = City.find_by_friendly_url(params[:id])
    end
    raise ActiveRecord::RecordNotFound if @city.nil?

    @countries = City.pluck('DISTINCT country').sort
    @rectangle_coordinates = get_rectangle_coordinates(@city.latitude, @city.longitude, 5).to_json
  end

  def get_cities
    render json: City.select(:id, :city, :friendly_url).where(:country => params[:country]).order(:city)
  end
end
