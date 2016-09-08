class CreateCountriesTable < ActiveRecord::Migration
  def change
    create_table "countries", force: true do |t|
      t.string   "name", limit: 25
      t.string   "code", limit: 2
    end
    add_index "countries", ["code"], name: "code_key", unique: true, using: :btree
  end
end
