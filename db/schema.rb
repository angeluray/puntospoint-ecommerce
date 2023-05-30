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

ActiveRecord::Schema[7.0].define(version: 2023_05_30_225744) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "password"
    t.string "password_confirmation"
    t.string "auth_token"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "jti", null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["jti"], name: "index_accounts_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "username"
    t.integer "role_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "products_count"
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_categories_on_account_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "address"
    t.decimal "balance"
    t.integer "purchases_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_images_on_product_id"
  end

  create_table "product_categorizations", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_product_categorizations_on_category_id"
    t.index ["product_id"], name: "index_product_categorizations_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "price"
    t.integer "sales_count"
    t.integer "product_stocks"
    t.integer "sold_products"
    t.decimal "product_earnings"
    t.boolean "available"
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_products_on_account_id"
  end

  create_table "sales", force: :cascade do |t|
    t.integer "product_amount"
    t.decimal "total_price"
    t.datetime "purchased_at"
    t.bigint "product_id", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_sales_on_account_id"
    t.index ["product_id"], name: "index_sales_on_product_id"
  end

  add_foreign_key "categories", "accounts"
  add_foreign_key "images", "products"
  add_foreign_key "product_categorizations", "categories"
  add_foreign_key "product_categorizations", "products"
  add_foreign_key "products", "accounts"
  add_foreign_key "sales", "accounts"
  add_foreign_key "sales", "products"
end
