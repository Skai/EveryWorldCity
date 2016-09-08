class AddCountryIdToCity < ActiveRecord::Migration
  def self.up
    add_column :cities, :country_id, :integer
  end

  def self.down
    remove_column :cities, :country_id
  end
end
