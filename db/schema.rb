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

ActiveRecord::Schema.define(:version => 20110330154407) do

  create_table "detail_schedules", :force => true do |t|
    t.date     "export_at"
    t.date     "minashi_date"
    t.string   "stage_name"
    t.date     "stage_start_date"
    t.date     "stage_end_date"
    t.integer  "wg_id"
    t.string   "wg_name"
    t.integer  "swg_id"
    t.string   "swg_name"
    t.float    "trend_bac_md"
    t.float    "total_bac_md"
    t.float    "trend_pv_md"
    t.float    "total_pv_md"
    t.float    "trend_ac_md"
    t.float    "total_ac_md"
    t.float    "trend_ev_md"
    t.float    "total_ev_md"
    t.date     "schedule_start_date"
    t.date     "schedule_end_date"
    t.float    "plan_total_bac"
    t.float    "total_est_md"
    t.integer  "task_no"
    t.string   "task_id_name"
    t.string   "Lvla_txt"
    t.string   "Lvlb_txt"
    t.string   "Lvlc_txt"
    t.string   "Lvld_txt"
    t.date     "start_plan_date"
    t.date     "start_act_date"
    t.date     "end_plan_date"
    t.date     "end_act_date"
    t.string   "team_name"
    t.string   "incharge_name"
    t.float    "est_md"
    t.string   "check_txt"
    t.string   "status"
    t.string   "memo"
    t.integer  "plan_duration_days"
    t.integer  "plan_burned_days"
    t.integer  "act_burned_days"
    t.float    "planned_md"
    t.float    "burned_md"
    t.float    "earned_md"
    t.float    "spi_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
