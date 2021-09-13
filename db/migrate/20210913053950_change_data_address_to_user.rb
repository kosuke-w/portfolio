class ChangeDataAddressToUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :address, :integer
  end
end
