class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.integer :coordinate_id
      t.datetime :start_time

      t.timestamps
    end
  end
end
