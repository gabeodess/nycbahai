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

ActiveRecord::Schema.define(version: 20170213002104) do

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
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

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
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["permissions"], name: "index_admin_users_on_permissions", using: :gin
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "contributer_email_addresses", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "key",        null: false
    t.index ["email"], name: "index_contributer_email_addresses_on_email", using: :btree
    t.index ["key"], name: "index_contributer_email_addresses_on_key", unique: true, using: :btree
    t.index ["name"], name: "index_contributer_email_addresses_on_name", unique: true, using: :btree
  end

  create_table "contributions", force: :cascade do |t|
    t.money    "amount",     scale: 2, null: false
    t.date     "date"
    t.integer  "num"
    t.string   "name"
    t.string   "fund"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "key",                  null: false
    t.index ["key"], name: "index_contributions_on_key", using: :btree
  end

  create_table "hosts", force: :cascade do |t|
    t.integer  "activity_id", null: false
    t.integer  "person_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["activity_id"], name: "index_hosts_on_activity_id", using: :btree
    t.index ["person_id"], name: "index_hosts_on_person_id", using: :btree
  end

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
    t.index ["activity_id"], name: "index_participants_on_activity_id", using: :btree
    t.index ["person_id"], name: "index_participants_on_person_id", using: :btree
  end

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
    t.index ["address"], name: "index_people_on_address", using: :gin
  end

  create_table "summary_emails", force: :cascade do |t|
    t.string   "contributer"
    t.integer  "year"
    t.datetime "sent_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["contributer", "year"], name: "index_summary_emails_on_contributer_and_year", unique: true, using: :btree
    t.index ["contributer"], name: "index_summary_emails_on_contributer", using: :btree
  end

  add_foreign_key "hosts", "activities"
  add_foreign_key "hosts", "people"
  add_foreign_key "participants", "activities"
  add_foreign_key "participants", "people"
end
