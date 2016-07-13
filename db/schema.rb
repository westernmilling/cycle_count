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

ActiveRecord::Schema.define(version: 20160708001452) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cycle_counts", force: :cascade do |t|
    t.integer  "location_id"
    t.datetime "requested_date", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "deleter_id"
  end

  add_index "cycle_counts", ["location_id"], name: "index_cycle_counts_on_location_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.integer  "location_number", null: false
    t.integer  "area_number",     null: false
    t.integer  "sequence_number", null: false
    t.string   "description",     null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "deleter_id"
  end

  create_table "pallets", force: :cascade do |t|
    t.integer  "cycle_count_id"
    t.string   "pallet_number",                      null: false
    t.string   "check_state",    default: "Pending"
    t.string   "check_location"
    t.string   "check_result"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "deleter_id"
    t.string   "notes"
  end

  add_index "pallets", ["cycle_count_id"], name: "index_pallets_on_cycle_count_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                               null: false
    t.integer  "is_active",              default: 1, null: false
    t.string   "email",                              null: false
    t.string   "role_name",                          null: false
    t.string   "encrypted_password"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",          default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "remember_created_at"
    t.integer  "failed_attempts",        default: 0, null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "cycle_counts", "locations"
  add_foreign_key "pallets", "cycle_counts"
end
