class AddNameToCoordinates < ActiveRecord::Migration[5.2]
  def change
    add_column :coordinates, :name, :string
  end
end
