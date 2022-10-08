class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.string :subject_title
      t.string :internal_marks
      t.string :external_marks
      t.string :total_marks
      t.string :result
      t.string :credits
      t.string :grade
      t.string :result_type
      t.string :user_id
      t.string :department_id
      t.string :batch_id
      t.string :regulation_id
      t.string :semester_id
      t.string :last_updated_user_id

      t.timestamps
    end
  end
end
