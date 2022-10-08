class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :keywords
      t.string :approval_status
      t.integer :reviewer1_id
      t.integer :reviewer2_id
      t.integer :reviewer3_id
      t.integer :user_id      

      t.timestamps
    end
  end
end
