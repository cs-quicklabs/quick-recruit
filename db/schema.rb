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

ActiveRecord::Schema[7.1].define(version: 2024_03_09_075506) do
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "candidates", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email"
    t.string "phone", null: false
    t.string "location"
    t.text "biography"
    t.string "linkedin"
    t.string "facebook"
    t.string "twitter"
    t.string "github"
    t.string "website"
    t.string "portfolio"
    t.string "current_company"
    t.string "current_title"
    t.string "current_ctc"
    t.string "expected_ctc"
    t.string "notice_period"
    t.integer "experience"
    t.integer "birth_year"
    t.string "highest_qualification"
    t.integer "bucket", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id"
    t.bigint "source_id"
    t.bigint "opening_id"
    t.bigint "user_id", default: 1, null: false
    t.index ["email"], name: "unique_emails", unique: true
    t.index ["opening_id"], name: "index_candidates_on_opening_id"
    t.index ["role_id"], name: "index_candidates_on_role_id"
    t.index ["source_id"], name: "index_candidates_on_source_id"
    t.index ["user_id"], name: "index_candidates_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "action"
    t.integer "eventable_id"
    t.string "eventable_type"
    t.string "action_for_context"
    t.integer "trackable_id"
    t.string "trackable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.text "body"
    t.string "notable_type"
    t.bigint "notable_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notable_type", "notable_id"], name: "index_notes_on_notable"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "openings", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sources", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.string "first_name"
    t.string "last_name"
    t.string "location"
    t.string "phone"
    t.text "biography"
    t.string "linkedin"
    t.string "facebook"
    t.string "twitter"
    t.string "github"
    t.string "website"
    t.string "portfolio"
    t.string "current_company"
    t.string "current_title"
    t.integer "experience"
    t.integer "birth_year"
    t.boolean "active", default: true
    t.datetime "inactive_at"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "candidates", "openings"
  add_foreign_key "candidates", "roles"
  add_foreign_key "candidates", "sources"
  add_foreign_key "candidates", "users"
  add_foreign_key "notes", "users"
end
