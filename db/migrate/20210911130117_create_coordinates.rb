class CreateCoordinates < ActiveRecord::Migration[5.2]
  def change
    create_table :coordinates do |t|
      t.integer :user_id
      t.integer :item_id
      t.string :comment
      t.integer :season

      t.timestamps
    end
  end
end
