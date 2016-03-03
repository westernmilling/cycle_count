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

ActiveRecord::Schema.define(version: 20160226014344) do

  create_table "cycle_counts", force: :cascade do |t|
    t.integer  "location_id",    limit: 4
    t.datetime "requested_date",           null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "creator_id",     limit: 4
    t.integer  "updater_id",     limit: 4
    t.integer  "deleter_id",     limit: 4
  end

  add_index "cycle_counts", ["location_id"], name: "index_cycle_counts_on_location_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.integer  "location_number", limit: 4,   null: false
    t.integer  "area_number",     limit: 4,   null: false
    t.integer  "sequence_number", limit: 4,   null: false
    t.string   "description",     limit: 255, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "creator_id",      limit: 4
    t.integer  "updater_id",      limit: 4
    t.integer  "deleter_id",      limit: 4
  end

  create_table "pallets", force: :cascade do |t|
    t.integer  "cycle_count_id", limit: 4
    t.string   "pallet_number",  limit: 255,                     null: false
    t.string   "check_state",    limit: 255, default: "Pending"
    t.string   "check_location", limit: 255
    t.string   "check_result",   limit: 255
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "creator_id",     limit: 4
    t.integer  "updater_id",     limit: 4
    t.integer  "deleter_id",     limit: 4
  end

  add_index "pallets", ["cycle_count_id"], name: "index_pallets_on_cycle_count_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255,             null: false
    t.integer  "is_active",              limit: 4,   default: 1, null: false
    t.string   "email",                  limit: 255,             null: false
    t.string   "role_name",              limit: 255,             null: false
    t.string   "encrypted_password",     limit: 255
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "remember_created_at"
    t.integer  "failed_attempts",        limit: 4,   default: 0, null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.string   "invitation_token",       limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit",       limit: 4
    t.integer  "invited_by_id",          limit: 4
    t.string   "invited_by_type",        limit: 255
    t.integer  "invitations_count",      limit: 4,   default: 0
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "cycle_counts", "locations"
  add_foreign_key "pallets", "cycle_counts"
end
