class AddUserToTutorial < ActiveRecord::Migration[6.1]
  def change
    add_column :tutorials, :user_id, :integer
  end
end
