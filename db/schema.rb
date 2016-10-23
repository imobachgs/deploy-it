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

ActiveRecord::Schema.define(version: 20161023230440) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: :cascade do |t|
    t.integer  "project_id", null: false
    t.integer  "machine_id", null: false
    t.integer  "role_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deployments", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "status_id",     null: false
    t.text     "configuration"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["project_id"], name: "index_deployments_on_project_id", using: :btree
  end

  create_table "machine_deployments", force: :cascade do |t|
    t.integer  "deployment_id"
    t.integer  "machine_id"
    t.integer  "status_id",                  null: false
    t.text     "log",           default: "", null: false
    t.text     "roles"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.datetime "started_at"
    t.datetime "finished_at"
    t.index ["deployment_id"], name: "index_machine_deployments_on_deployment_id", using: :btree
    t.index ["machine_id"], name: "index_machine_deployments_on_machine_id", using: :btree
    t.index ["status_id"], name: "index_machine_deployments_on_status_id", using: :btree
  end

  create_table "machines", force: :cascade do |t|
    t.string   "ip",         null: false
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.string   "repo_url"
    t.text     "desc"
    t.integer  "kind_id",                                    null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "user_id"
    t.string   "ruby_version",      default: "2"
    t.string   "database_adapter",  default: "postgresql"
    t.string   "database_name",     default: "rails"
    t.string   "database_username", default: "rails"
    t.string   "database_password", default: "rails"
    t.string   "secret",            default: ""
    t.string   "type",              default: "RailsProject", null: false
    t.integer  "port",              default: 80
    t.string   "db_admin_password", default: ""
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.text     "ssh_public_key"
    t.text     "ssh_private_key"
    t.string   "provider"
    t.string   "uid"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "deployments", "projects"
  add_foreign_key "machine_deployments", "deployments"
  add_foreign_key "machine_deployments", "machines"
end
