class FixColumnName < ActiveRecord::Migration[6.1]
  def self.up
    rename_column :videos, :video_url, :video_url
    rename_column :articles, :reference_url, :reference_url
    rename_column :documents, :reference_url, :reference_url
  end
end
