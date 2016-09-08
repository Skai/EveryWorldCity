class IndexController < ApplicationController
  include IndexHelper

  def show
    if params[:id] == 'random_city'
      @city = City.random
      return redirect_to @city
    end
    city_id = params[:id].nil? ? 'ukraine-kiev' : params[:id]
    @city = City.find_by_friendly_url!(city_id)
    @staticmap_url = get_staticmap_url(@city.latitude.to_s, @city.longitude.to_s)
    @wiki_url = get_wiki_url(@city.wiki_page_id.to_s)
    @googlemap_url = get_googlemap_url(@city.latitude.to_s, @city.longitude.to_s)
    @countries = Country.all.sort
    @city_count = City.unscoped.count
  end

  def get_cities
    render json: City.select(:id, :city, :friendly_url).where(:country_id => params[:country]).order(:city)
  end

  def get_photos
    render json: get_panoramio_json(params[:latitude].to_f, params[:longitude].to_f)
  end
end
