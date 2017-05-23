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

ActiveRecord::Schema.define(version: 20170523090915) do

  create_table "articles", force: :cascade do |t|
    t.string   "title",                    limit: 255,   null: false
    t.integer  "manufacturer_id",          limit: 4,     null: false
    t.datetime "manufactured_at"
    t.string   "reference",                limit: 13
    t.text     "blurb",                    limit: 65535
    t.integer  "size",                     limit: 4
    t.float    "price",                    limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cover_image_file_name",    limit: 255
    t.string   "cover_image_content_type", limit: 255
    t.integer  "cover_image_file_size",    limit: 4
    t.datetime "cover_image_updated_at"
  end

  add_index "articles", ["manufacturer_id"], name: "fk_articles_manufacturers", using: :btree

  create_table "articles_suppliers", force: :cascade do |t|
    t.integer  "supplier_id", limit: 4, null: false
    t.integer  "article_id",  limit: 4, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles_suppliers", ["article_id"], name: "fk_articles_suppliers_articles", using: :btree
  add_index "articles_suppliers", ["supplier_id"], name: "fk_articles_suppliers_suppliers", using: :btree

  create_table "cart_items", force: :cascade do |t|
    t.integer  "article_id", limit: 4
    t.integer  "cart_id",    limit: 4
    t.float    "price",      limit: 24
    t.integer  "amount",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_posts", force: :cascade do |t|
    t.string   "name",       limit: 50,                null: false
    t.string   "subject",    limit: 255,               null: false
    t.text     "body",       limit: 65535
    t.integer  "root_id",    limit: 4,     default: 0, null: false
    t.integer  "parent_id",  limit: 4,     default: 0, null: false
    t.integer  "depth",      limit: 4,     default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "article_id", limit: 4
    t.integer  "order_id",   limit: 4
    t.float    "price",      limit: 24
    t.integer  "amount",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_items", ["order_id"], name: "fk_order_items_orders", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "email",                limit: 255
    t.string   "phone_number",         limit: 255
    t.string   "ship_to_first_name",   limit: 255
    t.string   "ship_to_last_name",    limit: 255
    t.string   "ship_to_address",      limit: 255
    t.string   "ship_to_city",         limit: 255
    t.string   "ship_to_postal_code",  limit: 255
    t.string   "ship_to_country_code", limit: 255
    t.string   "customer_ip",          limit: 255
    t.string   "status",               limit: 255
    t.string   "error_message",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "first_name", limit: 255, null: false
    t.string   "last_name",  limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "user_sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",               limit: 255,             null: false
    t.string   "login",              limit: 255,             null: false
    t.string   "email",              limit: 255,             null: false
    t.string   "crypted_password",   limit: 255,             null: false
    t.string   "password_salt",      limit: 255,             null: false
    t.string   "persistence_token",  limit: 255,             null: false
    t.string   "perishable_token",   limit: 255,             null: false
    t.integer  "login_count",        limit: 4,   default: 0, null: false
    t.integer  "failed_login_count", limit: 4,   default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip",   limit: 255
    t.string   "last_login_ip",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "articles", "manufacturers", name: "fk_articles_manufacturers", on_delete: :cascade
  add_foreign_key "articles_suppliers", "articles", name: "fk_articles_suppliers_articles", on_delete: :cascade
  add_foreign_key "articles_suppliers", "suppliers", name: "fk_articles_suppliers_suppliers", on_delete: :cascade
  add_foreign_key "order_items", "orders", name: "fk_order_items_orders", on_delete: :cascade
end
