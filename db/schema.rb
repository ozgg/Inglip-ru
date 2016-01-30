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

ActiveRecord::Schema.define(version: 20160129222133) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lexemes", force: :cascade do |t|
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "part",       limit: 2,                 null: false
    t.integer  "obscenity",  limit: 2, default: 0,     null: false
    t.boolean  "verified",             default: false, null: false
    t.string   "body",                                 null: false
    t.string   "context"
    t.json     "data"
  end

  add_index "lexemes", ["body", "part"], name: "index_lexemes_on_body_and_part", using: :btree

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id",              null: false
    t.integer  "role",       limit: 2, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "user_roles", ["user_id", "role"], name: "index_user_roles_on_user_id_and_role", unique: true, using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "login",           null: false
    t.string   "password_digest", null: false
  end

  add_index "users", ["login"], name: "index_users_on_login", unique: true, using: :btree

  create_table "wordforms", force: :cascade do |t|
    t.integer "lexeme_id",           null: false
    t.integer "word_id",             null: false
    t.integer "indicator", limit: 2, null: false
  end

  add_index "wordforms", ["lexeme_id"], name: "index_wordforms_on_lexeme_id", using: :btree
  add_index "wordforms", ["word_id"], name: "index_wordforms_on_word_id", using: :btree

  create_table "words", force: :cascade do |t|
    t.string "stress"
    t.string "body",   null: false
  end

  add_index "words", ["body"], name: "index_words_on_body", using: :btree

  add_foreign_key "user_roles", "users"
  add_foreign_key "wordforms", "lexemes"
  add_foreign_key "wordforms", "words"
end
