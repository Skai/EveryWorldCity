# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140722210639) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: true do |t|
    t.string   "country",        limit: 25
    t.string   "city",           limit: 40,   default: "0"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "altitude"
    t.text     "description"
    t.boolean  "is_twitted",                  default: false, null: false
    t.datetime "updated_at"
    t.datetime "sent_at"
    t.integer  "wiki_page_id",                default: 0
    t.string   "wiki_image_src", limit: 1500
    t.datetime "created_at"
    t.string   "friendly_url",   limit: 1024
    t.string   "country_code",   limit: 2
  end

  add_index "cities", ["country_code"], name: "cities_code_key", unique: true, using: :btree
  add_index "cities", ["country_code"], name: "index_code", using: :btree
  add_index "cities", ["country_code"], name: "unique_code", unique: true, using: :btree
  add_index "cities", ["friendly_url"], name: "cities_friendly_url_key", unique: true, using: :btree
  add_index "cities", ["friendly_url"], name: "index_url", using: :btree
  add_index "cities", ["wiki_page_id"], name: "cities_wiki_page_id_idx", using: :btree
end
