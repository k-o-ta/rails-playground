# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_02_15_145932) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "post_publish_deletes", force: :cascade do |t|
    t.bigint "post_publish_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at", "post_publish_id"], name: "index_post_publish_deletes_on_created_at_and_post_publish_id", unique: true
    t.index ["post_publish_id"], name: "index_post_publish_deletes_on_post_publish_id"
  end

  create_table "post_publishes", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.date "published_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at", "post_id"], name: "index_post_publishes_on_created_at_and_post_id", unique: true
    t.index ["post_id"], name: "index_post_publishes_on_post_id"
  end

  create_table "post_screening_requests", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.string "requested_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_screening_requests_on_post_id"
  end

  create_table "post_screenings", force: :cascade do |t|
    t.bigint "post_screening_request_id", null: false
    t.string "status", null: false
    t.string "screened_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_screening_request_id"], name: "index_post_screenings_on_post_screening_request_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.string "author", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "post_publish_deletes", "post_publishes", on_delete: :cascade
  add_foreign_key "post_publishes", "posts", on_delete: :cascade
  add_foreign_key "post_screening_requests", "posts", on_delete: :cascade
  add_foreign_key "post_screenings", "post_screening_requests", on_delete: :cascade
end
