class AddIsDeleteToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :is_delete, :boolean
  end
end
