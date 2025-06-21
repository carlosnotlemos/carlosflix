class CreateMovies < ActiveRecord::Migration[8.0]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :description
      t.string :thumbnail_url
      t.string :video_master_url, null: false

      t.timestamps
    end

    add_index :movies, :slug, unique: true
  end
end
