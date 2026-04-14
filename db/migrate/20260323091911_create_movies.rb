class CreateMovies < ActiveRecord::Migration[8.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.integer :duration
      t.string :poster_url
      t.float :rating
      t.string :imdb_id

      t.timestamps
    end
  end
end
