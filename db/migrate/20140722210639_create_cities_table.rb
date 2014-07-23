class CreateCitiesTable < ActiveRecord::Migration
  def change
    create_table "cities", force: true do |t|
      t.string   "country", limit: 25
      t.string   "city", limit: 40,   default: "0"
      t.float    "latitude"
      t.float    "longitude"
      t.float    "altitude"
      t.text     "description"
      t.boolean  "is_twitted", default: false, null: false
      t.datetime "updated_at"
      t.datetime "sent_at"
      t.integer  "wiki_page_id", default: 0
      t.string   "wiki_image_src", limit: 1500
      t.datetime "created_at"
      t.string   "friendly_url", limit: 1024
      t.string   "country_code", limit: 2
    end
    add_index "cities", ["country_code"], name: "cities_code_key", unique: true, using: :btree
    add_index "cities", ["country_code"], name: "index_code", using: :btree
    add_index "cities", ["country_code"], name: "unique_code", unique: true, using: :btree
    add_index "cities", ["friendly_url"], name: "cities_friendly_url_key", unique: true, using: :btree
    add_index "cities", ["friendly_url"], name: "index_url", using: :btree
    add_index "cities", ["wiki_page_id"], name: "cities_wiki_page_id_idx", using: :btree
  end
end
