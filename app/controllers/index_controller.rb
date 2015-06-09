class IndexController < ApplicationController
  include IndexHelper

  def index
    @countries = City.pluck('DISTINCT country').sort
    @city = nil
    @city_count = City.unscoped.count
  end

  def show
    @city = City.find_by_friendly_url(params[:id])
    raise ActiveRecord::RecordNotFound if @city.nil?
    @staticmap_url = get_staticmap_url(@city.latitude.to_s, @city.longitude.to_s)
    @wiki_url = get_wiki_url(@city.wiki_page_id.to_s)
    @googlemap_url = get_googlemap_url(@city.latitude.to_s, @city.longitude.to_s)
    @countries = City.pluck('DISTINCT country').sort
  end

  def get_cities
    render json: City.select(:id, :city, :friendly_url).where(:country => params[:country]).order(:city)
  end

  def get_photos
    render json: get_panoramio_json(params[:latitude].to_f, params[:longitude].to_f)
  end
end
