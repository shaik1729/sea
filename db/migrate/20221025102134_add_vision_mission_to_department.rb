class AddVisionMissionToDepartment < ActiveRecord::Migration[6.1]
  def change
    add_column :departments, :vision, :text
    add_column :departments, :mission, :text
  end
end
