# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_08_17_031106) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.date "published_on"
    t.bigint "author_id", null: false
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_books_on_author_id"
  end

  create_table "episodes", force: :cascade do |t|
    t.bigint "podcast_id", null: false
    t.integer "number"
    t.string "title"
    t.string "url"
    t.string "youtube_url"
    t.date "released_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["podcast_id"], name: "index_episodes_on_podcast_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name", null: false
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people_roles", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "role_id", null: false
    t.boolean "main_author", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id", "role_id"], name: "index_people_roles_on_person_id_and_role_id", unique: true
    t.index ["person_id"], name: "index_people_roles_on_person_id"
    t.index ["role_id"], name: "index_people_roles_on_role_id"
  end

  create_table "podcasts", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_podcasts_on_person_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.text "content"
    t.integer "rating"
    t.string "reviewable_type", null: false
    t.bigint "reviewable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reviewable_type", "reviewable_id"], name: "index_reviews_on_reviewable"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string "title"
    t.date "released_on"
    t.string "youtube_url"
    t.string "spotify_url"
    t.bigint "singer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["singer_id"], name: "index_songs_on_singer_id"
  end

  add_foreign_key "books", "people", column: "author_id"
  add_foreign_key "episodes", "podcasts"
  add_foreign_key "people_roles", "people"
  add_foreign_key "people_roles", "roles"
  add_foreign_key "podcasts", "people"
  add_foreign_key "songs", "people", column: "singer_id"
end
