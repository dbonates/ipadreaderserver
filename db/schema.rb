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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130420071950) do

  create_table "contents", :force => true do |t|
    t.string   "text"
    t.string   "pages"
    t.integer  "issue_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "docs", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "issues", :force => true do |t|
    t.string   "name"
    t.string   "product_identifier"
    t.string   "cover"
    t.string   "pdf"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "magazine_id"
    t.boolean  "free"
    t.text     "description"
    t.string   "bigcover"
    t.string   "slug"
  end

  create_table "magazines", :force => true do |t|
    t.string   "name"
    t.string   "apps_id"
    t.string   "pem"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id"
    t.string   "shared_secret"
    t.boolean  "visible"
    t.string   "slug"
  end

  add_index "magazines", ["slug"], :name => "index_magazines_on_slug"

  create_table "previews", :force => true do |t|
    t.string   "image"
    t.integer  "issue_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "push_tokens", :force => true do |t|
    t.string   "token"
    t.integer  "magazine_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "name"
    t.string   "product_identifier"
    t.integer  "magazine_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "role"
    t.boolean  "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
