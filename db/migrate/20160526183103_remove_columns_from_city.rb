class RemoveColumnsFromCity < ActiveRecord::Migration
  def change
    remove_column :cities, :country
  end
end
