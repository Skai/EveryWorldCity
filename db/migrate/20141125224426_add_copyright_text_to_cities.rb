class AddCopyrightTextToCities < ActiveRecord::Migration
  def change
    add_column :cities, :copyright_text, :string
  end
end
