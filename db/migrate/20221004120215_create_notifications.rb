class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string :title
      t.integer :user_id
      t.integer :regulation_id
      t.integer :batch_id
      t.integer :department_id
      t.integer :course_id

      t.timestamps
    end
  end
end
