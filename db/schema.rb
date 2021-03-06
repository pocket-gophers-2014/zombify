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

ActiveRecord::Schema.define(:version => 20140529002705) do

  create_table "checkins", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ingredient_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "games", :force => true do |t|
    t.string   "city",        :default => "San Francisco"
    t.string   "game_code"
    t.string   "state",       :default => "California"
    t.string   "title",       :default => "Zombie Apocalypse"
    t.boolean  "game_active", :default => false
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.boolean  "cure_found",  :default => false
    t.boolean  "started",     :default => false
  end

  create_table "ingredients", :force => true do |t|
    t.string  "name"
    t.string  "code"
    t.float   "latitude"
    t.float   "longitude"
    t.boolean "discovered"
    t.boolean "harvested"
    t.string  "title"
    t.integer "counter"
    t.string  "address"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
  end

  create_table "messages", :force => true do |t|
    t.text    "title"
    t.text    "description"
    t.string  "audience"
    t.boolean "has_been_called", :default => false
    t.integer "game_id"
  end

  create_table "posts", :force => true do |t|
    t.text     "body"
    t.string   "title"
    t.string   "audience"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_ingredients", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ingredient_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string  "name"
    t.string  "email"
    t.string  "phone_number"
    t.string  "password_digest"
    t.string  "handle"
    t.boolean "can_cure",        :default => false
    t.boolean "infected",        :default => false
    t.integer "points",          :default => 0
    t.integer "cures",           :default => 0
    t.integer "infections",      :default => 0
    t.integer "mod"
    t.integer "game_id"
  end

end
