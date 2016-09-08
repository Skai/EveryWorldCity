class SetCountryIdToCity < ActiveRecord::Migration
  def change
    Country.all.each do |country|
      say "Setting id for country #{country.name}..."
      City.unscoped.where("country = '#{country.name}'").update_all(country_id: country.id)
    end
  end
end
