class RemoveColumnToItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :times_worn, :integer
    remove_column :items, :last_worn_day, :datetime
  end
end
