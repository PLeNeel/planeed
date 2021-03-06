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

ActiveRecord::Schema.define(version: 2021_09_02_145839) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.date "date"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_availabilities_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.string "progress"
    t.bigint "mission_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "seen"
    t.index ["mission_id"], name: "index_bookings_on_mission_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "service_id", null: false
    t.index ["service_id"], name: "index_chatrooms_on_service_id"
  end

  create_table "last_messages", force: :cascade do |t|
    t.bigint "message_id"
    t.bigint "user_id", null: false
    t.bigint "chatroom_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chatroom_id"], name: "index_last_messages_on_chatroom_id"
    t.index ["message_id"], name: "index_last_messages_on_message_id"
    t.index ["user_id"], name: "index_last_messages_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "chatroom_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "missions", force: :cascade do |t|
    t.date "date"
    t.string "description"
    t.bigint "service_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_id"], name: "index_missions_on_service_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "predominant_disease"
    t.string "typical_workday"
    t.string "predominant_drugs"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "toxics", force: :cascade do |t|
    t.string "name"
    t.integer "total_quantity"
    t.integer "current_quantity"
    t.bigint "service_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "barcode"
    t.index ["service_id"], name: "index_toxics_on_service_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "service_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "experience"
    t.string "speciality"
    t.string "phone_number"
    t.string "address"
    t.string "mail_address"
    t.string "service_admin"
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["service_id"], name: "index_users_on_service_id"
  end

  create_table "withdraws", force: :cascade do |t|
    t.integer "quantity"
    t.string "token"
    t.bigint "user_id", null: false
    t.bigint "toxic_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["toxic_id"], name: "index_withdraws_on_toxic_id"
    t.index ["user_id"], name: "index_withdraws_on_user_id"
  end

  add_foreign_key "availabilities", "users"
  add_foreign_key "bookings", "missions"
  add_foreign_key "bookings", "users"
  add_foreign_key "chatrooms", "services"
  add_foreign_key "last_messages", "chatrooms"
  add_foreign_key "last_messages", "messages"
  add_foreign_key "last_messages", "users"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "missions", "services"
  add_foreign_key "toxics", "services"
  add_foreign_key "users", "services"
  add_foreign_key "withdraws", "toxics"
  add_foreign_key "withdraws", "users"
end
