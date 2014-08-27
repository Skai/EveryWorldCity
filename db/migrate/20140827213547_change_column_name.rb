class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :cities, :is_twitted, :is_in_twitter
  end
end
