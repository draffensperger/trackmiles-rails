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

ActiveRecord::Schema.define(:version => 20130816223855) do

  create_table "calendar_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "calendar_id"
    t.string   "color_id"
    t.string   "background_color"
    t.string   "foreground_color"
    t.boolean  "hidden"
    t.boolean  "selected"
    t.string   "access_role"
    t.boolean  "primary"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "calendar_users", ["calendar_id", "user_id"], :name => "index_calendar_users_on_calendar_id_and_user_id", :unique => true

  create_table "calendars", :force => true do |t|
    t.string   "etag",             :default => "", :null => false
    t.string   "gcal_id",          :default => "", :null => false
    t.string   "summary",          :default => "", :null => false
    t.string   "description"
    t.string   "location"
    t.integer  "time_zone_id"
    t.string   "summary_override"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "calendars", ["gcal_id"], :name => "index_calendars_on_gcal_id", :unique => true

  create_table "locations", :force => true do |t|
    t.integer  "user_id"
    t.datetime "recorded_time"
    t.string   "provider"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.decimal  "altitude"
    t.decimal  "accuracy"
    t.decimal  "speed"
    t.decimal  "bearing"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
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
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
