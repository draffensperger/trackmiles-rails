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

ActiveRecord::Schema.define(version: 20131103214252) do

  create_table "calendar_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "calendar_id"
    t.string   "color_id"
    t.string   "background_color"
    t.string   "foreground_color"
    t.boolean  "hidden"
    t.boolean  "selected"
    t.string   "access_role"
    t.boolean  "primary"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "summary_override"
  end

  add_index "calendar_users", ["calendar_id", "user_id"], name: "index_calendar_users_on_calendar_id_and_user_id", unique: true, using: :btree

  create_table "calendars", force: true do |t|
    t.string   "etag",                   default: "", null: false
    t.string   "gcal_id",                default: "", null: false
    t.string   "summary",                default: "", null: false
    t.text     "description"
    t.string   "location"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "time_zone"
    t.datetime "last_synced"
    t.string   "last_synced_user_email"
  end

  add_index "calendars", ["gcal_id"], name: "index_calendars_on_gcal_id", unique: true, using: :btree

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.integer  "calendar_id"
    t.string   "etag"
    t.string   "gcal_event_id",                 default: "",                    null: false
    t.string   "status",                        default: "",                    null: false
    t.text     "html_link",                     default: "",                    null: false
    t.datetime "created",                       default: '2013-08-18 23:14:35', null: false
    t.datetime "updated",                       default: '2013-08-18 23:14:35', null: false
    t.string   "summary",                       default: "",                    null: false
    t.text     "description"
    t.text     "location"
    t.string   "creator_id"
    t.string   "creator_email"
    t.string   "creator_display_name"
    t.boolean  "creator_self"
    t.string   "organizer_id"
    t.string   "organizer_email"
    t.string   "organizer_display_name"
    t.boolean  "organizer_self"
    t.date     "start_date"
    t.datetime "start_date_time"
    t.string   "start_time_zone"
    t.date     "end_date"
    t.datetime "end_date_time"
    t.string   "end_time_zone"
    t.text     "recurrence"
    t.string   "recurring_event_id"
    t.date     "original_start_time_date"
    t.datetime "original_start_time_date_time"
    t.string   "original_start_time_time_zone"
    t.string   "transparency"
    t.string   "visibility"
    t.string   "i_cal_uid"
    t.integer  "sequence"
    t.boolean  "end_time_unspecified"
    t.string   "hangout_link"
    t.datetime "start_datetime_utc"
    t.datetime "end_datetime_utc"
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.boolean  "private_copy"
    t.boolean  "locked"
    t.string   "source_url"
    t.string   "source_title"
    t.text     "attendees"
    t.text     "extended_properties"
    t.text     "gadget"
    t.text     "reminders"
    t.boolean  "anyone_can_add_self"
    t.boolean  "guests_can_invite_others"
    t.boolean  "guests_can_modify"
    t.boolean  "guests_can_see_other_guests"
    t.boolean  "attendees_omitted"
  end

  add_index "events", ["calendar_id", "gcal_event_id"], name: "index_events_on_calendar_id_and_gcal_event_id", unique: true, using: :btree

  create_table "locations", force: true do |t|
    t.integer  "user_id"
    t.datetime "recorded_time"
    t.string   "provider"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "altitude"
    t.float    "accuracy"
    t.float    "speed"
    t.float    "bearing"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.float    "n_vector_x"
    t.float    "n_vector_y"
    t.float    "n_vector_z"
  end

  create_table "place_roles", force: true do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.string   "role",               default: "", null: false
    t.string   "custom_summary"
    t.string   "custom_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "place_roles", ["place_id"], name: "index_place_roles_on_place_id", using: :btree
  add_index "place_roles", ["user_id"], name: "index_place_roles_on_user_id", using: :btree

  create_table "places", force: true do |t|
    t.string   "summary",       default: "", null: false
    t.text     "description"
    t.string   "street"
    t.string   "city"
    t.string   "postal_code"
    t.string   "county"
    t.string   "state"
    t.integer  "country_id"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.decimal  "accuracy"
    t.string   "accuracy_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trip_events", force: true do |t|
    t.integer  "trip_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trip_separator_areas", force: true do |t|
    t.integer  "trip_separator_region_id"
    t.float    "total_x"
    t.float    "total_y"
    t.float    "total_z"
    t.float    "num_locations"
    t.datetime "first_time"
    t.datetime "last_time"
    t.float    "x"
    t.float    "y"
    t.float    "z"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trip_separator_areas", ["trip_separator_region_id"], name: "index_trip_separator_areas_on_trip_separator_region_id", using: :btree

  create_table "trip_separator_regions", force: true do |t|
    t.integer  "user_id"
    t.integer  "anchor_area_id"
    t.datetime "last_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trip_separator_regions", ["user_id"], name: "index_trip_separator_regions_on_user_id", using: :btree

  create_table "trips", force: true do |t|
    t.integer  "user_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "method"
    t.integer  "start_place_id"
    t.integer  "end_place_id"
    t.float    "distance"
    t.string   "type"
    t.string   "purpose"
    t.boolean  "from_phone"
    t.boolean  "from_calendar"
    t.boolean  "reimbursed"
    t.boolean  "archived"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trips", ["user_id"], name: "index_trips_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                     default: "", null: false
    t.string   "encrypted_password",        default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "google_auth_token"
    t.string   "google_auth_refresh_token"
    t.datetime "google_auth_expires_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
