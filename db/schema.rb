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

ActiveRecord::Schema.define(version: 2018_04_23_232646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "browsers", force: :cascade do |t|
    t.string "browser_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "releases", default: "{}"
  end

  create_table "features", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "mdn_url"
    t.boolean "deprecated"
    t.boolean "experimental"
    t.boolean "standard_track"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "chrome", default: "{}"
    t.jsonb "chrome_android", default: "{}"
    t.jsonb "edge", default: "{}"
    t.jsonb "edge_mobile", default: "{}"
    t.jsonb "firefox", default: "{}"
    t.jsonb "firefox_android", default: "{}"
    t.jsonb "ie", default: "{}"
    t.jsonb "nodejs", default: "{}"
    t.jsonb "opera", default: "{}"
    t.jsonb "qq_android", default: "{}"
    t.jsonb "safari", default: "{}"
    t.jsonb "safari_ios", default: "{}"
    t.jsonb "samsunginternet_android", default: "{}"
    t.jsonb "uc_android", default: "{}"
    t.jsonb "uc_chinese_android", default: "{}"
    t.jsonb "webview_android", default: "{}"
  end

end
