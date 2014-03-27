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

ActiveRecord::Schema.define(:version => 20140327043648) do

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.integer  "hack_id"
    t.string   "action"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "hack_id"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "private",    :default => false
  end

  create_table "contributions", :force => true do |t|
    t.integer  "hack_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hackdays", :force => true do |t|
    t.string   "title"
    t.date     "date"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.boolean  "presentation_in_progress"
  end

  create_table "hackdays_users", :force => true do |t|
    t.integer "hackday_id"
    t.integer "user_id"
  end

  create_table "hacks", :force => true do |t|
    t.string   "title"
    t.text     "description",        :limit => 255
    t.integer  "votes",                             :default => 0
    t.string   "url"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.integer  "presentation_index"
    t.text     "upvoted_by",                        :default => "'"
    t.text     "downvoted_by",                      :default => "'"
    t.integer  "hackday_id"
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "uid"
    t.string   "email"
    t.string   "mugshot_url"
  end

end
