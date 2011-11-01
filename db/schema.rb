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

ActiveRecord::Schema.define(:version => 20111018183327) do

  create_table "addresses", :force => true do |t|
    t.integer  "record_id"
    t.text     "line1"
    t.text     "line2"
    t.text     "city"
    t.text     "state"
    t.text     "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "beneficiaries", :force => true do |t|
    t.text     "name"
    t.text     "relationship"
    t.integer  "record_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "beneficiaries", ["record_id"], :name => "index_beneficiaries_on_record_id"

  create_table "courts", :force => true do |t|
    t.text     "name"
    t.text     "street"
    t.text     "town"
    t.date     "instituted_on"
    t.string   "gender"
    t.string   "closed_on"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courts_ethnicities", :id => false, :force => true do |t|
    t.integer "court_id"
    t.integer "ethnicity_id"
  end

  create_table "ethnicities", :force => true do |t|
    t.text     "name"
    t.integer  "court_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "names", :force => true do |t|
    t.text     "first"
    t.text     "middle"
    t.text     "last"
    t.text     "title"
    t.integer  "record_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "names", ["record_id"], :name => "index_names_on_record_id"

  create_table "records", :force => true do |t|
    t.integer  "claim_id"
    t.integer  "court_id"
    t.integer  "age_at_initiation"
    t.text     "initiated_on_year"
    t.text     "initiated_on_month"
    t.text     "initiated_on_date"
    t.text     "died_on_year"
    t.text     "died_on_month"
    t.text     "died_on_date"
    t.string   "beneficiary_name"
    t.text     "suspended_on_year"
    t.text     "suspended_on_month"
    t.text     "suspended_on_date"
    t.text     "reinstated_on_year"
    t.text     "reinstated_on_month"
    t.text     "reinstated_on_date"
    t.text     "withdrawn_on_year"
    t.text     "withdrawn_on_month"
    t.text     "withdrawn_on_date"
    t.integer  "transferred_id"
    t.text     "transferred_on_year"
    t.text     "transferred_on_month"
    t.text     "transferred_on_date"
    t.text     "paid_on_year"
    t.text     "paid_on_month"
    t.text     "paid_on_date"
    t.integer  "register_no"
    t.string   "birth_city"
    t.string   "birth_county"
    t.string   "birth_state"
    t.string   "birth_country"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "delta",                :default => true, :null => false
  end

  add_index "records", ["court_id"], :name => "index_records_on_court_id"
  add_index "records", ["transferred_id"], :name => "index_records_on_transferred_id"

  create_table "transfers", :force => true do |t|
    t.integer  "record_id"
    t.integer  "court_id"
    t.text     "transferred_on_year"
    t.text     "transferred_on_month"
    t.text     "transferred_on_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transfers", ["court_id"], :name => "index_transfers_on_court_id"

end
