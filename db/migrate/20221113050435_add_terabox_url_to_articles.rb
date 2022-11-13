class AddTeraboxUrlToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :terabox_url, :string
  end
end
