class IndexController < ApplicationController
  include IndexHelper
  
  def show
    #go to random city for homepage.
    if params[:id].nil?
      @city = City.limit(1).order('RANDOM()').first
      flash[:notice] = "It's a random city"
      redirect_to @city
      return
    end

    @city = City.find_by_friendly_url(params[:id])
    raise ActiveRecord::RecordNotFound if @city.nil?
    
    @staticmap_url = get_staticmap_url(@city.latitude.to_s, @city.longitude.to_s)
    @wiki_url = get_wiki_url(@city.wiki_page_id.to_s)
    @googlemap_url = get_googlemap_url(@city.latitude.to_s, @city.longitude.to_s)
    @countries = City.pluck('DISTINCT country').sort
    @rectangle_coordinates = get_rectangle_coordinates(@city.latitude, @city.longitude, 5).to_json
  end

  def get_cities
    render json: City.select(:id, :city, :friendly_url).where(:country => params[:country]).order(:city)
  end
end
