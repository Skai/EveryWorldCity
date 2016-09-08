class CopyCountriesContent < ActiveRecord::Migration
  def self.up
    City.pluck('DISTINCT country').sort.each do |country|
      Country.create(name: country)
    end
  end

  def self.down
    Country.delete_all
  end
end
