# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 5) do

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.integer "sender_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "receivers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "senders", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transmissions", force: :cascade do |t|
    t.string "name"
    t.integer "transport_id", null: false
    t.integer "message_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["message_id"], name: "index_transmissions_on_message_id"
    t.index ["transport_id"], name: "index_transmissions_on_transport_id"
  end

  create_table "transports", force: :cascade do |t|
    t.string "name"
    t.integer "receiver_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "receiver_id"], name: "index_transports_on_name_and_receiver_id", unique: true
  end

  add_foreign_key "messages", "senders"
  add_foreign_key "transmissions", "messages"
  add_foreign_key "transmissions", "transports"
  add_foreign_key "transports", "receivers"
end
