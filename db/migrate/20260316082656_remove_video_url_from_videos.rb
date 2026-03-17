class RemoveVideoUrlFromVideos < ActiveRecord::Migration[8.1]
  def change
    remove_column :videos, :video_url, :string
  end
end
