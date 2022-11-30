class AddTeraboxUrlToDocuments < ActiveRecord::Migration[6.1]
  def change
    add_column :documents, :terabox_url, :string
  end
end
