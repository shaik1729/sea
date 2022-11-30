class AddTeraboxUrlToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :reference_url, :string
  end
end
