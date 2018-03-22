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

ActiveRecord::Schema.define(version: 20180322195152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "course_corequisites", force: :cascade do |t|
    t.integer "course_id"
    t.integer "corequisite_id"
  end

  create_table "courses", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.text     "textbooks"
    t.text     "grades"
    t.text     "day"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "class_minimum"
    t.integer  "class_maximum"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "courses_products", force: :cascade do |t|
    t.integer "course_id"
    t.integer "product_id"
  end

  create_table "invoice_line_items", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.integer  "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parents", force: :cascade do |t|
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "phone_number",           limit: 16
    t.string   "first_name"
    t.string   "last_name"
    t.text     "street_address_1"
    t.text     "street_address_2"
    t.text     "city"
    t.text     "state"
    t.text     "zip_code"
    t.text     "tuition_preference"
    t.boolean  "admin",                             default: false
  end

  add_index "parents", ["email"], name: "index_parents_on_email", unique: true, using: :btree
  add_index "parents", ["reset_password_token"], name: "index_parents_on_reset_password_token", unique: true, using: :btree

  create_table "products", force: :cascade do |t|
    t.text     "name"
    t.integer  "unit_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "course_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "status",     default: "selected"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shadow_spots", force: :cascade do |t|
    t.text     "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "date"
    t.integer  "subject_id"
  end

  create_table "student_shadows", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "shadow_spot_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "student_shadows", ["shadow_spot_id"], name: "index_student_shadows_on_shadow_spot_id", using: :btree
  add_index "student_shadows", ["student_id"], name: "index_student_shadows_on_student_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "grade"
    t.integer  "parent_id"
    t.boolean  "lunch",                default: false
    t.date     "date_of_birth"
    t.text     "student_email"
    t.text     "learning_differences"
    t.text     "emergency_contact"
    t.text     "emergency_phone"
  end

  create_table "subjects", force: :cascade do |t|
    t.text     "name"
    t.integer  "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "teacher_id"
  end

  add_index "subjects", ["teacher_id"], name: "index_subjects_on_teacher_id", using: :btree

  create_table "teachers", force: :cascade do |t|
    t.text     "first_name"
    t.text     "last_name"
    t.text     "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "subject_id"
  end

  create_table "wait_listed_students", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "student_shadows", "shadow_spots"
  add_foreign_key "student_shadows", "students"
  add_foreign_key "students", "parents"
  add_foreign_key "subjects", "teachers"
end
