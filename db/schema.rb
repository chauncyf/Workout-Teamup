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

ActiveRecord::Schema.define(version: 2018_11_04_021822) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.datetime "activity_date"
    t.string "place"
    t.text "content"
    t.integer "starter_id"
    t.integer "status"
    t.integer "estimatedDuration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activity_participants", force: :cascade do |t|
    t.integer "participant_id"
    t.integer "activity_id"
    t.integer "identity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activity_tags", force: :cascade do |t|
    t.integer "activity_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "activity_id"
    t.integer "user_id"
    t.text "content"
    t.integer "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "follows", force: :cascade do |t|
    t.integer "followee_id"
    t.integer "follower_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gyms", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.integer "activity_id"
    t.integer "user_id"
    t.string "photo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "activity_id"
    t.integer "user_id"
    t.string "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "type_name"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_locations", force: :cascade do |t|
    t.integer "user_id"
    t.float "latitude"
    t.float "longitude"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  # identity  1: admin 2: user
  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "password_digest"
    t.string "email"
    t.string "potrait_url"
    t.float "height"
    t.float "weight"
    t.text "physical_condition"
    t.text "motto"
    t.integer "identity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
