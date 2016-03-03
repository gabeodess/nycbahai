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

ActiveRecord::Schema.define(version: 20160224163525) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "activities", force: :cascade do |t|
    t.string   "type",                        null: false
    t.date     "last_update_on",              null: false
    t.jsonb    "address",        default: {}, null: false
    t.jsonb    "contact",        default: {}, null: false
    t.string   "borough"
    t.string   "neighborhood"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.jsonb    "permissions",            default: [], null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["permissions"], name: "index_admin_users_on_permissions", using: :gin
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "contributer_email_addresses", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contributer_email_addresses", ["email"], name: "index_contributer_email_addresses_on_email", using: :btree
  add_index "contributer_email_addresses", ["name"], name: "index_contributer_email_addresses_on_name", unique: true, using: :btree

  create_table "contributions", force: :cascade do |t|
    t.money    "amount",     scale: 2, null: false
    t.date     "date"
    t.integer  "num"
    t.string   "name"
    t.string   "fund"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "hosts", force: :cascade do |t|
    t.integer  "activity_id", null: false
    t.integer  "person_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "hosts", ["activity_id"], name: "index_hosts_on_activity_id", using: :btree
  add_index "hosts", ["person_id"], name: "index_hosts_on_person_id", using: :btree

  create_table "imports", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "activity_id",                null: false
    t.integer  "person_id"
    t.boolean  "bahai",       default: true, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "description"
  end

  add_index "participants", ["activity_id"], name: "index_participants_on_activity_id", using: :btree
  add_index "participants", ["person_id"], name: "index_participants_on_person_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.date     "declared_on"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.jsonb    "address"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "gender"
  end

  add_index "people", ["address"], name: "index_people_on_address", using: :gin

  create_table "summary_emails", force: :cascade do |t|
    t.string   "contributer"
    t.integer  "year"
    t.datetime "sent_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "summary_emails", ["contributer", "year"], name: "index_summary_emails_on_contributer_and_year", unique: true, using: :btree
  add_index "summary_emails", ["contributer"], name: "index_summary_emails_on_contributer", using: :btree

  add_foreign_key "hosts", "activities"
  add_foreign_key "hosts", "people"
  add_foreign_key "participants", "activities"
  add_foreign_key "participants", "people"
end
