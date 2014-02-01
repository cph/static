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

ActiveRecord::Schema.define(version: 20140201210047) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assessments", force: true do |t|
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manager_reviewers", force: true do |t|
    t.integer  "manager_review_id", null: false
    t.string   "email_address",     null: false
    t.string   "token",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "completed_at"
    t.text     "results"
  end

  create_table "manager_reviews", force: true do |t|
    t.integer  "manager_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "completed_at"
  end

  create_table "scores", force: true do |t|
    t.integer  "scorer_id"
    t.integer  "user_id"
    t.integer  "value",                         null: false
    t.integer  "assessment_id"
    t.integer  "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "pass",          default: false, null: false
  end

  add_index "scores", ["assessment_id"], name: "index_scores_on_assessment_id", using: :btree
  add_index "scores", ["scorer_id", "user_id", "assessment_id", "skill_id"], name: "index_scores_on_all_associations", unique: true, using: :btree
  add_index "scores", ["scorer_id"], name: "index_scores_on_scorer_id", using: :btree
  add_index "scores", ["skill_id"], name: "index_scores_on_skill_id", using: :btree
  add_index "scores", ["user_id"], name: "index_scores_on_user_id", using: :btree

  create_table "skills", force: true do |t|
    t.string   "name",                        null: false
    t.string   "category",                    null: false
    t.text     "description",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shortname"
    t.string   "novice_abilities",                         array: true
    t.string   "advanced_beginner_abilities",              array: true
    t.string   "competent_abilities",                      array: true
    t.string   "proficient_abilities",                     array: true
    t.string   "master_abilities",                         array: true
  end

  create_table "user_assessments", force: true do |t|
    t.integer  "assessment_id"
    t.integer  "user_id"
    t.datetime "completed_at"
  end

  add_index "user_assessments", ["assessment_id", "user_id"], name: "index_user_assessments_on_assessment_id_and_user_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",                              null: false
    t.string   "last_name",                               null: false
    t.string   "type",                   default: "User", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
