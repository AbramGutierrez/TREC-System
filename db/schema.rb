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

ActiveRecord::Schema.define(version: 20150417154836) do

  create_table "accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "email"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "accounts", ["user_type", "user_id"], name: "index_accounts_on_user_type_and_user_id"

  create_table "administrators", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conferences", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "max_team_size"
    t.integer  "min_team_size"
    t.integer  "max_teams"
    t.float    "tamu_cost"
    t.float    "other_cost"
    t.text     "challenge_desc"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "is_active"
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "team_id"
    t.boolean  "captain"
    t.boolean  "waiver_signed"
    t.string   "shirt_size"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "phone"
  end

  add_index "participants", ["team_id"], name: "index_participants_on_team_id"

  create_table "sponsors", force: :cascade do |t|
    t.integer  "conference_id"
    t.string   "sponsor_name"
    t.string   "logo_path"
    t.integer  "priority"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "sponsors", ["conference_id"], name: "index_sponsors_on_conference_id"

  create_table "teams", force: :cascade do |t|
    t.integer  "conference_id"
    t.string   "team_name"
    t.string   "paid_status"
    t.string   "school"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "teams", ["conference_id"], name: "index_teams_on_conference_id"

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
