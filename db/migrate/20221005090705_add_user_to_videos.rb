class AddUserToVideos < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :user_id, :integer
  end
end
