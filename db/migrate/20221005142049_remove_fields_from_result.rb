class RemoveFieldsFromResult < ActiveRecord::Migration[6.1]
  def change
    remove_column :results, :department_id, :integer
    remove_column :results, :regulation_id, :integer
    remove_column :results, :batch_id, :integer
  end
end
