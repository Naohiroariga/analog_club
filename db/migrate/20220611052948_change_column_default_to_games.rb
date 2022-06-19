class ChangeColumnDefaultToGames < ActiveRecord::Migration[6.1]
  def change
    change_column_default :games, :is_delete, from: nil, to: false
  end
end
