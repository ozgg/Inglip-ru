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

ActiveRecord::Schema.define(version: 20141129220519) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "nouns", force: true do |t|
    t.integer  "user_id"
    t.boolean  "approved",             default: false, null: false
    t.integer  "grammatical_gender",                   null: false
    t.integer  "grammatical_number",                   null: false
    t.boolean  "animated",                             null: false
    t.boolean  "has_locative",         default: false, null: false
    t.boolean  "has_partitive",        default: false, null: false
    t.boolean  "common_gender",        default: false, null: false
    t.boolean  "mutual_gender",        default: false, null: false
    t.string   "nominative",                           null: false
    t.string   "genitive",                             null: false
    t.string   "dative",                               null: false
    t.string   "instrumental",                         null: false
    t.string   "prepositional",                        null: false
    t.string   "plural_nominative"
    t.string   "plural_genitive"
    t.string   "plural_dative"
    t.string   "plural_instrumental"
    t.string   "plural_prepositional"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nouns", ["approved"], name: "index_nouns_on_approved", using: :btree
  add_index "nouns", ["nominative"], name: "index_nouns_on_nominative", unique: true, using: :btree
  add_index "nouns", ["user_id"], name: "index_nouns_on_user_id", using: :btree

  create_table "prepositions", force: true do |t|
    t.string   "name",                          null: false
    t.boolean  "genitive",      default: false
    t.boolean  "dative",        default: false
    t.boolean  "accusative",    default: false
    t.boolean  "instrumental",  default: false
    t.boolean  "prepositional", default: false
    t.boolean  "locative",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prepositions", ["name"], name: "index_prepositions_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "login"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
