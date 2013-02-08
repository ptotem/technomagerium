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

ActiveRecord::Schema.define(:version => 20130206071128) do

  create_table "encyclopedia_entries", :force => true do |t|
    t.integer  "puzzle_id"
    t.integer  "attack"
    t.integer  "defense"
    t.integer  "magic"
    t.integer  "speed"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "games", :force => true do |t|
    t.integer  "user_id"
    t.integer  "puzzle_id"
    t.boolean  "lore",       :default => false
    t.boolean  "counter",    :default => false
    t.boolean  "revelation", :default => false
    t.boolean  "solved",     :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "revealed"
  end

  create_table "puzzles", :force => true do |t|
    t.integer  "tome_id"
    t.string   "name"
    t.string   "combo"
    t.integer  "power_reward"
    t.integer  "mana_reward"
    t.text     "lore"
    t.text     "explanation"
    t.string   "clue_cost_schema"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.boolean  "manacost"
    t.integer  "sequence"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "story_pages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "num"
    t.text     "progress"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "chapter_break", :default => false
  end

  create_table "tomes", :force => true do |t|
    t.string   "name"
    t.string   "theme"
    t.string   "elements"
    t.boolean  "completed"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "cover_page_file_name"
    t.string   "cover_page_content_type"
    t.integer  "cover_page_file_size"
    t.datetime "cover_page_updated_at"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.integer  "sequence"
    t.boolean  "openable"
    t.integer  "chapter",                 :default => 1
    t.text     "beginning"
    t.text     "ending"
    t.boolean  "manual_freeze",           :default => false
  end

  create_table "user_states", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tome_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "bookmark"
  end

  create_table "users", :force => true do |t|
    t.boolean  "admin",                  :default => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "power",                  :default => 0
    t.integer  "mana",                   :default => 0
    t.integer  "score",                  :default => 0
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
