class FixColumnName < ActiveRecord::Migration[6.1]
  def self.up
    rename_column :videos, :terabox_video_url, :video_url
    rename_column :articles, :terabox_url, :reference_url
    rename_column :documents, :terabox_url, :reference_url
  end
end
