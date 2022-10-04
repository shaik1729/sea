class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.string :title
      t.string :keywords
      t.string :approved_status
      t.integer :reviewer1_id
      t.integer :reviewer2_id
      t.integer :reviewer3_id
      t.integer :user_id

      t.timestamps
    end
  end
end
