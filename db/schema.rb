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

ActiveRecord::Schema.define(version: 20161109232800) do

  create_table "artifacts", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "coordinate"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "artifacts_users", id: false, force: :cascade do |t|
    t.integer "user_id",     null: false
    t.integer "artifact_id", null: false
  end

  add_index "artifacts_users", ["artifact_id"], name: "index_artifacts_users_on_artifact_id"
  add_index "artifacts_users", ["user_id"], name: "index_artifacts_users_on_user_id"

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups_users", id: false, force: :cascade do |t|
    t.integer "user_id",  null: false
    t.integer "group_id", null: false
  end

  add_index "groups_users", ["group_id"], name: "index_groups_users_on_group_id"
  add_index "groups_users", ["user_id"], name: "index_groups_users_on_user_id"

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "coordinate"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
