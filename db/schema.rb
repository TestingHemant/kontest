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

ActiveRecord::Schema.define(version: 20161122105509) do

  create_table "contests", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.string   "contest_type",       limit: 255
    t.string   "banner",             limit: 255
    t.text     "description",        limit: 65535
    t.text     "steps",              limit: 65535
    t.string   "first_prize",        limit: 255
    t.string   "second_prize",       limit: 255
    t.string   "third_prize",        limit: 255
    t.string   "status",             limit: 255
    t.string   "suspension_reason",  limit: 255
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  create_table "entries", force: :cascade do |t|
    t.integer  "contest_id",         limit: 4
    t.string   "uploaded_image",     limit: 255
    t.string   "uploaded_video",     limit: 255
    t.string   "caption",            limit: 255
    t.string   "mobile",             limit: 15
    t.string   "email",              limit: 255
    t.string   "votes",              limit: 20
    t.string   "shares",             limit: 20
    t.string   "status",             limit: 50
    t.string   "rejected_reason",    limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  add_index "entries", ["contest_id"], name: "index_entries_on_contest_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "name",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "entry_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_foreign_key "entries", "contests"
end
