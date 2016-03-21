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

ActiveRecord::Schema.define(version: 20160321091837) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "friend_ships", force: :cascade do |t|
    t.integer  "request_from_id", index: {name: "index_friend_ships_on_request_from_id"}, foreign_key: {references: "users", name: "fk_friend_ships_request_from_id", on_update: :no_action, on_delete: :no_action}
    t.integer  "request_to_id",   index: {name: "index_friend_ships_on_request_to_id"}, foreign_key: {references: "users", name: "fk_friend_ships_request_to_id", on_update: :no_action, on_delete: :no_action}
    t.integer  "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id",   index: {name: "index_messages_on_sender_id"}, foreign_key: {references: "users", name: "fk_messages_sender_id", on_update: :no_action, on_delete: :no_action}
    t.integer  "receiver_id", index: {name: "index_messages_on_receiver_id"}, foreign_key: {references: "users", name: "fk_messages_receiver_id", on_update: :no_action, on_delete: :no_action}
    t.text     "message"
    t.integer  "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "read_at"
  end

end
