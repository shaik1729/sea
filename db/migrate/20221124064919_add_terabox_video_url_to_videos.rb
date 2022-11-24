class AddTeraboxVideoUrlToVideos < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :terabox_video_url, :string
  end
end
