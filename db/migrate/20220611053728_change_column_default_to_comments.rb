class ChangeColumnDefaultToComments < ActiveRecord::Migration[6.1]
  def change
    change_column_default :comments, :is_delete, from: nil, to: false
  end
end
