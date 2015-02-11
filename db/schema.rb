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

ActiveRecord::Schema.define(version: 20150211210007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adjectives", force: true do |t|
    t.boolean  "approved",                default: false, null: false
    t.integer  "user_id"
    t.boolean  "qualitative",             default: false, null: false
    t.boolean  "possessive",              default: false, null: false
    t.boolean  "participle",              default: false, null: false
    t.boolean  "superlative",             default: false, null: false
    t.string   "nominative_masculine",                    null: false
    t.string   "genitive_masculine",                      null: false
    t.string   "dative_masculine",                        null: false
    t.string   "accusative_masculine",                    null: false
    t.string   "instrumental_masculine",                  null: false
    t.string   "prepositional_masculine",                 null: false
    t.string   "nominative_feminine",                     null: false
    t.string   "genitive_feminine",                       null: false
    t.string   "dative_feminine",                         null: false
    t.string   "accusative_feminine",                     null: false
    t.string   "instrumental_feminine",                   null: false
    t.string   "prepositional_feminine",                  null: false
    t.string   "nominative_neuter",                       null: false
    t.string   "genitive_neuter",                         null: false
    t.string   "dative_neuter",                           null: false
    t.string   "accusative_neuter",                       null: false
    t.string   "instrumental_neuter",                     null: false
    t.string   "prepositional_neuter",                    null: false
    t.string   "nominative_plural",                       null: false
    t.string   "genitive_plural",                         null: false
    t.string   "dative_plural",                           null: false
    t.string   "accusative_plural",                       null: false
    t.string   "instrumental_plural",                     null: false
    t.string   "prepositional_plural",                    null: false
    t.string   "partial"
    t.string   "comparative"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "adjectives", ["approved"], name: "index_adjectives_on_approved", using: :btree
  add_index "adjectives", ["nominative_masculine"], name: "index_adjectives_on_nominative_masculine", unique: true, using: :btree
  add_index "adjectives", ["user_id"], name: "index_adjectives_on_user_id", using: :btree

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
    t.string   "accusative",                           null: false
    t.string   "instrumental",                         null: false
    t.string   "prepositional",                        null: false
    t.string   "plural_nominative"
    t.string   "plural_genitive"
    t.string   "plural_dative"
    t.string   "plural_accusative"
    t.string   "plural_instrumental"
    t.string   "plural_prepositional"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nouns", ["approved"], name: "index_nouns_on_approved", using: :btree
  add_index "nouns", ["nominative"], name: "index_nouns_on_nominative", unique: true, using: :btree
  add_index "nouns", ["user_id"], name: "index_nouns_on_user_id", using: :btree

  create_table "perfect_verbs", force: true do |t|
    t.boolean  "approved",             default: false, null: false
    t.integer  "user_id"
    t.boolean  "has_reflexive",        default: true,  null: false
    t.boolean  "has_reciprocal",       default: false, null: false
    t.boolean  "has_neuter",           default: false, null: false
    t.integer  "valency",              default: 3,     null: false
    t.string   "infinitive",                           null: false
    t.string   "imperative"
    t.string   "gerund"
    t.string   "passive_masculine"
    t.string   "passive_feminine"
    t.string   "passive_neuter"
    t.string   "passive_plural"
    t.string   "past_masculine"
    t.string   "past_feminine"
    t.string   "past_neuter"
    t.string   "past_plural"
    t.string   "future_first"
    t.string   "future_second"
    t.string   "future_third"
    t.string   "future_first_plural"
    t.string   "future_second_plural"
    t.string   "future_third_plural"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "perfect_verbs", ["approved"], name: "index_perfect_verbs_on_approved", using: :btree
  add_index "perfect_verbs", ["infinitive"], name: "index_perfect_verbs_on_infinitive", unique: true, using: :btree
  add_index "perfect_verbs", ["user_id"], name: "index_perfect_verbs_on_user_id", using: :btree

  create_table "posts", force: true do |t|
    t.string   "title",      null: false
    t.text     "body",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "verbs", force: true do |t|
    t.integer  "user_id"
    t.boolean  "approved",              default: false, null: false
    t.boolean  "has_reflexive",         default: true,  null: false
    t.boolean  "has_reciprocal",        default: false, null: false
    t.boolean  "has_neuter",            default: false, null: false
    t.integer  "valency",               default: 3,     null: false
    t.string   "infinitive",                            null: false
    t.string   "imperative"
    t.string   "gerund"
    t.string   "gerund_past"
    t.string   "present_first"
    t.string   "present_second"
    t.string   "present_third"
    t.string   "present_first_plural"
    t.string   "present_second_plural"
    t.string   "present_third_plural"
    t.string   "past_masculine"
    t.string   "past_feminine"
    t.string   "past_neuter"
    t.string   "past_plural"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "verbs", ["approved"], name: "index_verbs_on_approved", using: :btree
  add_index "verbs", ["infinitive"], name: "index_verbs_on_infinitive", unique: true, using: :btree
  add_index "verbs", ["user_id"], name: "index_verbs_on_user_id", using: :btree

end
