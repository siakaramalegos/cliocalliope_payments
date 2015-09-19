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

ActiveRecord::Schema.define(version: 20150919201108) do

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "contact_name"
    t.string   "email"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "user_id"
    t.string   "stripe_customer_id"
  end

  add_index "customers", ["user_id"], name: "index_customers_on_user_id"

  create_table "invoices", force: :cascade do |t|
    t.integer  "number"
    t.integer  "customer_id"
    t.date     "invoice_date"
    t.date     "due_date"
    t.decimal  "total_amount"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "invoices", ["customer_id"], name: "index_invoices_on_customer_id"

  create_table "payments", force: :cascade do |t|
    t.integer  "invoice_id"
    t.decimal  "total_payment"
    t.string   "notes"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "payments", ["invoice_id"], name: "index_payments_on_invoice_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "role"
  end

end
