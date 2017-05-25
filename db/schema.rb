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

ActiveRecord::Schema.define(version: 20170525103501) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_answers_on_question_id", using: :btree
    t.index ["user_id"], name: "index_answers_on_user_id", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "patron_id"
    t.index ["patron_id"], name: "index_groups_on_patron_id", using: :btree
  end

  create_table "majors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_memberships_on_group_id", using: :btree
    t.index ["user_id"], name: "index_memberships_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "recipient_id"
    t.integer  "actor_id"
    t.datetime "read_at"
    t.string   "action"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "profile_skills", force: :cascade do |t|
    t.integer  "profile_id"
    t.integer  "skill_id"
    t.integer  "order",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["profile_id"], name: "index_profile_skills_on_profile_id", using: :btree
    t.index ["skill_id"], name: "index_profile_skills_on_skill_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "facebook_uid"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "major_id"
    t.text     "bio"
    t.string   "username"
    t.integer  "school_id"
    t.index ["major_id"], name: "index_profiles_on_major_id", using: :btree
    t.index ["school_id"], name: "index_profiles_on_school_id", using: :btree
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_questions_on_group_id", using: :btree
    t.index ["user_id"], name: "index_questions_on_user_id", using: :btree
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "logo"
  end

  create_table "users", force: :cascade do |t|
    t.string   "google_uid"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "patron_id"
    t.string   "student_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["patron_id"], name: "index_users_on_patron_id", using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.boolean "flag"
    t.integer "user_id"
    t.string  "votable_type"
    t.integer "votable_id"
    t.index ["user_id"], name: "index_votes_on_user_id", using: :btree
    t.index ["votable_id", "votable_type"], name: "index_votes_on_votable_id_and_votable_type", using: :btree
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "groups", "users", column: "patron_id"
  add_foreign_key "memberships", "groups"
  add_foreign_key "memberships", "users"
  add_foreign_key "profile_skills", "profiles"
  add_foreign_key "profile_skills", "skills"
  add_foreign_key "profiles", "majors"
  add_foreign_key "profiles", "schools"
  add_foreign_key "profiles", "users"
  add_foreign_key "questions", "groups"
  add_foreign_key "questions", "users"
  add_foreign_key "votes", "users"
end
