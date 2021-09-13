class RemoveItemIdFromCoordinates < ActiveRecord::Migration[5.2]
  def change
    remove_column :coordinates, :item_id, :integer
  end
end
