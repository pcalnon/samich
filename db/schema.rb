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

ActiveRecord::Schema.define(version: 20140624200237) do

  create_table "groups", force: true do |t|
    t.string   "name"
    t.string   "primary_investigator"
    t.string   "department"
    t.string   "office"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["name"], name: "index_groups_on_name", unique: true

  create_table "job_queues", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "walltime_default"
    t.string   "walltime_minimum"
    t.string   "walltime_maximum"
    t.string   "memory_default"
    t.string   "memory_maximum"
    t.string   "cores_default"
    t.string   "cores_maximum"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "job_queues", ["name"], name: "index_job_queues_on_name", unique: true

  create_table "jobs", force: true do |t|
    t.string   "job_id"
    t.integer  "user_id"
    t.integer  "queue_id"
    t.string   "name"
    t.string   "nodes_requested"
    t.integer  "cores_requested"
    t.string   "memory_requested"
    t.string   "walltime_requested"
    t.string   "submit_flags"
    t.string   "node_list"
    t.string   "nodes_used"
    t.integer  "cores_used"
    t.string   "memory_used"
    t.string   "walltime_used"
    t.string   "submit_time"
    t.string   "start_time"
    t.string   "completion_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
