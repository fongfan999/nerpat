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

ActiveRecord::Schema.define(version: 20170411132712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "majors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "major_id"
    t.text     "bio"
    t.string   "username"
    t.integer  "school_id"
    t.string   "avatar_image_file_name"
    t.string   "avatar_image_content_type"
    t.integer  "avatar_image_file_size"
    t.datetime "avatar_image_updated_at"
    t.index ["major_id"], name: "index_profiles_on_major_id", using: :btree
    t.index ["school_id"], name: "index_profiles_on_school_id", using: :btree
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
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
  end

  create_table "users", force: :cascade do |t|
    t.string   "google_uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "patron_id"
    t.string   "student_id"
    t.string   "first_name"
    t.string   "last_name"
    t.index ["patron_id"], name: "index_users_on_patron_id", using: :btree
  end

end
