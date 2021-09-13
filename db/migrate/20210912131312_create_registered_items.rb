class CreateRegisteredItems < ActiveRecord::Migration[5.2]
  def change
    create_table :registered_items do |t|
      t.integer :item_id
      t.integer :coordinate_id

      t.timestamps
    end
  end
end
