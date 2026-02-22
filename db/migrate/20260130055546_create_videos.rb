class CreateVideos < ActiveRecord::Migration[8.1]
  def change
    create_table :videos do |t|
      t.belongs_to :channel, null: false, foreign_key: true
      t.string   :title
      t.text     :description
      t.integer  :duration
      t.string   :video_url

      t.timestamps
    end
  end
end
