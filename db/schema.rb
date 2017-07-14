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

ActiveRecord::Schema.define(version: 20170714112411) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "albums", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "is_main",      default: false
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "photos_count", default: 0
    t.index ["user_id"], name: "index_albums_on_user_id", using: :btree
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

  create_table "taggings", id: false, force: :cascade do |t|
    t.integer "tag_id"
    t.string  "taggable_type"
    t.integer "taggable_id"
    t.index ["tag_id", "taggable_id", "taggable_type"], name: "index_taggings_on_tag_id_and_taggable_id_and_taggable_type", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "text",           limit: 20
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "taggings_count",            default: 0
    t.index ["text"], name: "index_tags_on_text", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                       default: "",     null: false
    t.string   "encrypted_password",          default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "first_name",                                   null: false
    t.string   "last_name",                                    null: false
    t.string   "address"
    t.string   "avatar"
    t.string   "role",                        default: "user"
    t.integer  "followers_count",             default: 0
    t.boolean  "follower_email_notification", default: true
    t.boolean  "comment_email_notificaton",   default: true
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
  add_foreign_key "taggings", "tags", on_delete: :cascade
end
