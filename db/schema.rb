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

ActiveRecord::Schema.define(version: 2021_08_27_185001) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "plan_reviews", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.bigint "review_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plan_id"], name: "index_plan_reviews_on_plan_id"
    t.index ["review_id"], name: "index_plan_reviews_on_review_id"
  end

  create_table "plans", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "genre_id", null: false
    t.string "name"
    t.datetime "created_on"
    t.datetime "deadline"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_id"], name: "index_plans_on_genre_id"
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "report_items", force: :cascade do |t|
    t.string "content", null: false
    t.bigint "report_id", null: false
    t.bigint "genre_id", null: false
    t.float "work_hours"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_id"], name: "index_report_items_on_genre_id"
    t.index ["report_id"], name: "index_report_items_on_report_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_on"
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id", null: false
    t.datetime "created_on"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_reviews_on_user_id"
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

  add_foreign_key "plan_reviews", "plans"
  add_foreign_key "plan_reviews", "reviews"
  add_foreign_key "plans", "genres"
  add_foreign_key "plans", "users"
  add_foreign_key "report_items", "genres"
  add_foreign_key "report_items", "reports"
  add_foreign_key "reports", "users"
  add_foreign_key "reviews", "users"
end
