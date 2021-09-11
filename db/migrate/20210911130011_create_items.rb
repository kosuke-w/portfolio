class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :user_id
      t.string :name
      t.string :image_id
      t.integer :genre
      t.integer :color
      t.integer :price
      t.string :brand
      t.string :caption
      t.integer :times_worn, default: 0
      t.datetime :last_worn_day

      t.timestamps
    end
  end
end
