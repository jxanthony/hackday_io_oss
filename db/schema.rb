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

ActiveRecord::Schema.define(:version => 20131021231122) do

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.integer  "hack_id"
    t.string   "action"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "admin_comments", :force => true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "hack_id"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "admin_comment"
  end

  create_table "contributions", :force => true do |t|
    t.integer  "hack_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hacks", :force => true do |t|
    t.string   "title"
    t.text     "description",        :limit => 255
    t.integer  "votes",                             :default => 0
    t.string   "url"
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.integer  "requested_hackers"
    t.integer  "presentation_index"
    t.integer  "creator_id"
    t.text     "upvoted_by",                        :default => "'--- []\n'"
    t.text     "downvoted_by",                      :default => "'--- []\n'"
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.integer  "bankroll",         :default => 10
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "admin"
    t.integer  "uid"
    t.string   "email"
    t.string   "mugshot_url"
    t.boolean  "mc"
  end

end
