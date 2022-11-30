class AddTeraboxUrlToDocuments < ActiveRecord::Migration[6.1]
  def change
    add_column :documents, :reference_url, :string
  end
end
