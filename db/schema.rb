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

ActiveRecord::Schema.define(version: 20170427122257) do

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

  create_table "manufacturers", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "first_name", limit: 255, null: false
    t.string   "last_name",  limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "articles", "manufacturers", name: "fk_articles_manufacturers", on_delete: :cascade
  add_foreign_key "articles_suppliers", "articles", name: "fk_articles_suppliers_articles", on_delete: :cascade
  add_foreign_key "articles_suppliers", "suppliers", name: "fk_articles_suppliers_suppliers", on_delete: :cascade
end
