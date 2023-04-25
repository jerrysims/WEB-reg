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

ActiveRecord::Schema.define(version: 2023_04_21_103039) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

  create_table "additional_contacts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.bigint "student_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_additional_contacts_on_student_id"
  end

  create_table "course_corequisites", force: :cascade do |t|
    t.integer "course_id"
    t.integer "corequisite_id"
  end

  create_table "courses", force: :cascade do |t|
    t.text "name"
    t.text "description"
    t.text "textbooks"
    t.text "grades"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "suggested_grade"
    t.text "subject_area"
    t.string "teacher"
    t.string "division"
    t.boolean "twice_weekly"
    t.bigint "registration_period_id"
    t.index ["registration_period_id"], name: "index_courses_on_registration_period_id"
  end

  create_table "courses_products", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "product_id"
    t.index ["course_id"], name: "index_courses_products_on_course_id"
    t.index ["product_id"], name: "index_courses_products_on_product_id"
  end

  create_table "invoice_line_items", force: :cascade do |t|
    t.integer "student_id"
    t.integer "product_id"
    t.integer "quantity"
    t.integer "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.boolean "paid"
  end

  create_table "invoices", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_id"
    t.boolean "closed", default: false
    t.index ["parent_id"], name: "index_invoices_on_parent_id"
  end

  create_table "learning_differences_forms", force: :cascade do |t|
    t.text "learning_differences"
    t.text "successful_accomodations"
    t.text "home_accomodations"
    t.text "anything_else"
    t.bigint "student_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_learning_differences_forms_on_student_id"
  end

  create_table "medical_forms", force: :cascade do |t|
    t.string "parent2_first_name"
    t.string "parent2_last_name"
    t.string "parent2_phone"
    t.string "emergency_contact_first_name"
    t.string "emergency_contact_last_name"
    t.string "emergency_contact_relationship"
    t.text "known_allergies"
    t.text "medical_needs_or_concerns"
    t.text "current_medications"
    t.string "physician_first_name"
    t.string "physician_last_name"
    t.string "physician_phone"
    t.string "medical_insurance_provider"
    t.string "medical_insurance_policy_number"
    t.string "preferred_hospital"
    t.boolean "pain_reliever_permission"
    t.boolean "medical_care_consent"
    t.string "signature"
    t.bigint "student_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_medical_forms_on_student_id"
  end

  create_table "parent_agreements", force: :cascade do |t|
    t.boolean "agree_to_pay"
    t.boolean "late_fee_acknowledgment"
    t.boolean "no_refund_on_voluntary_withdraw"
    t.boolean "prorate_on_requested_withdraw"
    t.boolean "plan_to_volunteer"
    t.boolean "volunteer_buyout"
    t.boolean "late_fee_for_late_pickup"
    t.string "signature"
    t.bigint "parent_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_id"], name: "index_parent_agreements_on_parent_id"
  end

  create_table "parents", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number", limit: 16
    t.string "first_name"
    t.string "last_name"
    t.text "street_address_1"
    t.text "street_address_2"
    t.text "city"
    t.text "state"
    t.text "zip_code"
    t.text "tuition_preference"
    t.boolean "admin", default: false
    t.boolean "locked", default: false
    t.text "payment_preference"
    t.boolean "is_admin"
    t.string "secondary_email"
    t.boolean "covid_statement_acknowledged"
    t.boolean "reg_fees_paid"
    t.index ["email"], name: "index_parents_on_email", unique: true
    t.index ["reset_password_token"], name: "index_parents_on_reset_password_token", unique: true
  end

  create_table "parents_roles", id: false, force: :cascade do |t|
    t.bigint "parent_id"
    t.bigint "role_id"
    t.index ["parent_id", "role_id"], name: "index_parents_roles_on_parent_id_and_role_id"
    t.index ["parent_id"], name: "index_parents_roles_on_parent_id"
    t.index ["role_id"], name: "index_parents_roles_on_role_id"
  end

  create_table "photo_consents", force: :cascade do |t|
    t.boolean "permission_and_consent"
    t.string "signature"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "parent_id", null: false
    t.index ["parent_id"], name: "index_photo_consents_on_parent_id"
  end

  create_table "products", force: :cascade do |t|
    t.text "name"
    t.float "unit_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "product_type"
  end

  create_table "registration_logs", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "section_id"
    t.bigint "user_id", null: false
    t.string "previous_status"
    t.string "new_status"
    t.datetime "changed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_registration_logs_on_section_id"
    t.index ["student_id"], name: "index_registration_logs_on_student_id"
    t.index ["user_id"], name: "index_registration_logs_on_user_id"
  end

  create_table "registration_periods", force: :cascade do |t|
    t.string "name"
    t.date "open_date"
    t.date "close_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "rp_type"
  end

  create_table "registrations", force: :cascade do |t|
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "selected"
    t.bigint "section_id"
    t.bigint "user_id"
    t.index ["section_id"], name: "index_registrations_on_section_id"
    t.index ["student_id", "section_id"], name: "index_registrations_on_student_id_and_section_id", unique: true
    t.index ["user_id"], name: "index_registrations_on_user_id"
  end

  create_table "release_of_liabilities", force: :cascade do |t|
    t.boolean "waiver_terms"
    t.boolean "dalewood_terms"
    t.string "signature"
    t.bigint "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_id"], name: "index_release_of_liabilities_on_parent_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string "day"
    t.time "start_time"
    t.time "end_time"
    t.integer "class_minimum"
    t.integer "class_maximum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "course_id"
    t.integer "students_count", default: 0, null: false
  end

  create_table "shadow_spots", force: :cascade do |t|
    t.text "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "date"
    t.bigint "subject_id"
    t.index ["subject_id"], name: "index_shadow_spots_on_subject_id"
  end

  create_table "student_shadows", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "shadow_spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shadow_spot_id"], name: "index_student_shadows_on_shadow_spot_id"
    t.index ["student_id"], name: "index_student_shadows_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "grade"
    t.bigint "parent_id"
    t.boolean "lunch", default: false
    t.date "date_of_birth"
    t.string "student_email"
    t.text "learning_differences"
    t.string "emergency_contact"
    t.string "emergency_phone"
    t.boolean "confirmed_grade", default: true
    t.string "race"
    t.string "pronouns"
    t.string "web_email"
    t.string "nickname"
    t.boolean "learning_differences_flag"
    t.index ["parent_id"], name: "index_students_on_parent_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.text "name"
    t.integer "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "teacher_id"
    t.index ["teacher_id"], name: "index_subjects_on_teacher_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.text "first_name"
    t.text "last_name"
    t.text "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "subject_id"
    t.index ["subject_id"], name: "index_teachers_on_subject_id"
  end

  create_table "wait_listed_students", force: :cascade do |t|
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "section_id"
    t.index ["section_id"], name: "index_wait_listed_students_on_section_id"
    t.index ["student_id", "section_id"], name: "index_wait_listed_students_on_student_id_and_section_id", unique: true
  end

  add_foreign_key "additional_contacts", "students"
  add_foreign_key "courses", "registration_periods"
  add_foreign_key "invoices", "parents"
  add_foreign_key "learning_differences_forms", "students"
  add_foreign_key "parent_agreements", "parents"
  add_foreign_key "photo_consents", "parents"
  add_foreign_key "registration_logs", "parents", column: "user_id"
  add_foreign_key "registration_logs", "sections"
  add_foreign_key "registration_logs", "students"
  add_foreign_key "registrations", "parents", column: "user_id"
  add_foreign_key "registrations", "sections"
  add_foreign_key "student_shadows", "shadow_spots"
  add_foreign_key "student_shadows", "students"
  add_foreign_key "students", "parents"
  add_foreign_key "subjects", "teachers"
  add_foreign_key "wait_listed_students", "sections"
end
