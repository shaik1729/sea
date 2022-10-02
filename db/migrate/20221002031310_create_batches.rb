class CreateBatches < ActiveRecord::Migration[6.1]
  def change
    create_table :batches do |t|
      t.string :code
      t.date :start_year
      t.date :end_year

      t.timestamps
    end
  end
end
