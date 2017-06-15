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

ActiveRecord::Schema.define(version: 20170612123121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "is_main",     default: false
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["user_id"], name: "index_albums_on_user_id", using: :btree
  end

  create_table "albums_tags", id: false, force: :cascade do |t|
    t.integer "album_id", null: false
    t.integer "tag_id",   null: false
    t.index ["album_id", "tag_id"], name: "index_albums_tags_on_album_id_and_tag_id", using: :btree
    t.index ["tag_id", "album_id"], name: "index_albums_tags_on_tag_id_and_album_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.string   "text"
    t.integer  "user_id"
    t.integer  "photo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["photo_id"], name: "index_comments_on_photo_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "followerships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["followed_id"], name: "index_followerships_on_followed_id", using: :btree
    t.index ["follower_id", "followed_id"], name: "index_followerships_on_follower_id_and_followed_id", unique: true, using: :btree
    t.index ["follower_id"], name: "index_followerships_on_follower_id", using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.text     "description"
    t.string   "image"
    t.integer  "album_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["album_id"], name: "index_photos_on_album_id", using: :btree
  end

  create_table "photos_tags", id: false, force: :cascade do |t|
    t.integer "photo_id", null: false
    t.integer "tag_id",   null: false
    t.index ["photo_id", "tag_id"], name: "index_photos_tags_on_photo_id_and_tag_id", using: :btree
    t.index ["tag_id", "photo_id"], name: "index_photos_tags_on_tag_id_and_photo_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "text",       limit: 20
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["text"], name: "index_tags_on_text", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.string   "address"
    t.string   "avatar"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["last_name", "first_name"], name: "index_users_on_last_name_and_first_name", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "albums", "users", on_delete: :cascade
  add_foreign_key "comments", "photos", on_delete: :cascade
  add_foreign_key "comments", "users", on_delete: :cascade
  add_foreign_key "followerships", "users", column: "followed_id", on_delete: :cascade
  add_foreign_key "followerships", "users", column: "follower_id", on_delete: :cascade
  add_foreign_key "photos", "albums", on_delete: :cascade
end
