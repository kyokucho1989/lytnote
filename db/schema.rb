# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_24_203328) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "done_lists", force: :cascade do |t|
    t.string "content"
    t.bigint "user_daily_comment_id", null: false
    t.bigint "genre_id", null: false
    t.float "work_hours"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_id"], name: "index_done_lists_on_genre_id"
    t.index ["user_daily_comment_id"], name: "index_done_lists_on_user_daily_comment_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "plan_lists", force: :cascade do |t|
    t.string "plan_name"
    t.bigint "user_id", null: false
    t.bigint "genre_id", null: false
    t.datetime "deadline"
    t.bigint "status_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_id"], name: "index_plan_lists_on_genre_id"
    t.index ["status_id"], name: "index_plan_lists_on_status_id"
    t.index ["user_id"], name: "index_plan_lists_on_user_id"
  end

  create_table "plan_review_lists", force: :cascade do |t|
    t.bigint "plan_list_id", null: false
    t.bigint "user_review_comment_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plan_list_id"], name: "index_plan_review_lists_on_plan_list_id"
    t.index ["user_review_comment_id"], name: "index_plan_review_lists_on_user_review_comment_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_daily_comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "daily_comment", null: false
    t.datetime "created_comment_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_daily_comments_on_user_id"
  end

  create_table "user_review_comments", force: :cascade do |t|
    t.string "review_comment", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_review_comments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "done_lists", "genres"
  add_foreign_key "done_lists", "user_daily_comments"
  add_foreign_key "plan_lists", "genres"
  add_foreign_key "plan_lists", "statuses"
  add_foreign_key "plan_lists", "users"
  add_foreign_key "plan_review_lists", "plan_lists"
  add_foreign_key "plan_review_lists", "user_review_comments"
  add_foreign_key "user_daily_comments", "users"
  add_foreign_key "user_review_comments", "users"
end
