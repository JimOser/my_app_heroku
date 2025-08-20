class CreatePodcasts < ActiveRecord::Migration[7.1]
  def change

    create_table :podcasts do |t|
      t.string :title, null: false
      t.text   :description
      t.timestamps
    end
    add_check_constraint :podcasts, "char_length(btrim(title)) > 0", name: "podcasts_title_not_blank"
  end
end
