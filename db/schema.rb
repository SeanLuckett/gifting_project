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

ActiveRecord::Schema.define(:version => 20121211213644) do

  create_table "events", :force => true do |t|
    t.string   "title",                        :null => false
    t.date     "date",                         :null => false
    t.integer  "user_id"
    t.boolean  "repeats",    :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "events_recipients", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "recipient_id"
  end

  add_index "events_recipients", ["event_id", "recipient_id"], :name => "index_events_recipients_on_event_id_and_recipient_id"
  add_index "events_recipients", ["recipient_id", "event_id"], :name => "index_events_recipients_on_recipient_id_and_event_id"

  create_table "personas", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "personas_recipients", :id => false, :force => true do |t|
    t.integer "persona_id"
    t.integer "recipient_id"
  end

  add_index "personas_recipients", ["persona_id", "recipient_id"], :name => "index_personas_recipients_on_persona_id_and_recipient_id"
  add_index "personas_recipients", ["recipient_id", "persona_id"], :name => "index_personas_recipients_on_recipient_id_and_persona_id"

  create_table "recipients", :force => true do |t|
    t.string   "fb_id"
    t.string   "name"
    t.string   "image"
    t.date     "birthday"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "user_id"
    t.integer  "spend_at_least"
    t.integer  "spend_at_most"
    t.string   "address1"
    t.string   "address2"
    t.string   "state",          :limit => 2
    t.string   "city"
    t.string   "zip_code"
  end

  create_table "recommended_gifts", :force => true do |t|
    t.integer  "recipient_id"
    t.integer  "event_id"
    t.string   "gift_name"
    t.string   "gift_url"
    t.boolean  "bought"
    t.datetime "buy_date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "email"
    t.string   "image"
    t.boolean  "email_confirmed",  :default => false
  end

end
