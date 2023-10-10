class AddIsDeletedToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_deleted, :boolean
  end
end
