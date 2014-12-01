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

ActiveRecord::Schema.define(version: 20141130215715) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "cities", force: true do |t|
    t.string   "country",                    limit: 25,   default: "0"
    t.string   "city",                       limit: 40,   default: "0"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "altitude"
    t.text     "description"
    t.boolean  "is_in_twitter",                           default: false, null: false
    t.datetime "updated_at"
    t.datetime "sent_at"
    t.integer  "wiki_page_id",                            default: 0
    t.string   "wiki_image_src",             limit: 1500
    t.datetime "created_at"
    t.string   "friendly_url",               limit: 1024
    t.string   "copyright_text"
    t.string   "twitter_image_file_name"
    t.string   "twitter_image_content_type"
    t.integer  "twitter_image_file_size"
    t.datetime "twitter_image_updated_at"
  end

  add_index "cities", ["friendly_url"], name: "cities_friendly_url_key", unique: true, using: :btree
  add_index "cities", ["friendly_url"], name: "index_url", using: :btree
  add_index "cities", ["wiki_page_id"], name: "cities_wiki_page_id_idx", using: :btree

end
