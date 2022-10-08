class CreateRegulations < ActiveRecord::Migration[6.1]
  def change
    create_table :regulations do |t|
      t.string :name
      t.string :code, unique: true

      t.timestamps
    end
  end
end
